<?php
session_start();
require_once 'config/database.php';

if (!isset($_SESSION['user_email'])) {
    header('Location: login.php');
    exit();
}

// Get current user from database
$currentUser = getUserByEmail($_SESSION['user_email']);

if (!$currentUser) {
    die("User not found.");
}

// Map database fields to expected format
$currentUser['full_name'] = $currentUser['display_name'] ?? $currentUser['full_name'];
$currentUser['account_number'] = $currentUser['account_number'] ?? '';
$currentUser['contact_number'] = $currentUser['contact_number'] ?? '';
// Note: job and monthly_salary are not in bank_users table
// You may need to add these fields to the database or use defaults
$currentUser['job'] = 'Not Specified'; // Default value
$currentUser['monthly_salary'] = 0; // Default value

// Get database connection
$conn = getDBConnection();
if (!$conn) {
    die("DB Connection failed.");
}

// Get form data
$loan_type = $_POST['loan_type'] ?? '';
$loan_terms = $_POST['loan_terms'] ?? '12 Months';
$loan_amount = floatval($_POST['loan_amount'] ?? 0);
$purpose = $_POST['purpose'] ?? '';

// Parse term months
$term_months = (int) filter_var($loan_terms, FILTER_SANITIZE_NUMBER_INT);
$term_months = max(1, $term_months);

// Calculate monthly payment (20% annual interest)
$annual_rate = 0.20;
$monthly_rate = $annual_rate / 12;
if ($monthly_rate > 0 && $term_months > 0) {
    $monthly_payment = $loan_amount * ($monthly_rate * pow(1 + $monthly_rate, $term_months)) / (pow(1 + $monthly_rate, $term_months) - 1);
} else {
    $monthly_payment = $loan_amount / $term_months;
}

// Due date - Calculate the exact final payment date (same day, X months later)
$today = new DateTime();
$due_date_obj = clone $today;
$due_date_obj->modify("+$term_months months");
$due_date = $due_date_obj->format('Y-m-d');

// Handle file uploads - Updated to handle 3 files
$target_dir = "uploads/";
if (!is_dir($target_dir)) mkdir($target_dir, 0777, true);

// Valid ID
$valid_id_path = "";
if (!empty($_FILES['attachment']['name'])) {
    $valid_id_path = $target_dir . basename($_FILES["attachment"]["name"]);
    move_uploaded_file($_FILES["attachment"]["tmp_name"], $valid_id_path);
}

// Proof of Income
$proof_income_path = "";
if (!empty($_FILES['proof_of_income']['name'])) {
    $proof_income_path = $target_dir . basename($_FILES["proof_of_income"]["name"]);
    move_uploaded_file($_FILES["proof_of_income"]["tmp_name"], $proof_income_path);
}

// Certificate of Employment (COE)
$coe_path = "";
if (!empty($_FILES['coe_document']['name'])) {
    $coe_path = $target_dir . basename($_FILES["coe_document"]["name"]);
    move_uploaded_file($_FILES["coe_document"]["tmp_name"], $coe_path);
}

// Validate that all required files are uploaded
if (empty($valid_id_path) || empty($proof_income_path) || empty($coe_path)) {
    die("Error: All document uploads are required.");
}

// Save to DB - Updated to include new document fields
$stmt = $conn->prepare("
    INSERT INTO loan_applications (
        full_name, account_number, contact_number, email,
        job, monthly_salary,
        loan_type, loan_terms, loan_amount, purpose, 
        file_name, proof_of_income, coe_document,
        monthly_payment, due_date, status
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')
");

$stmt->bind_param(
    "sssssdssdssssds",
    $currentUser['full_name'],
    $currentUser['account_number'],
    $currentUser['contact_number'],
    $currentUser['email'],
    $currentUser['job'],
    $currentUser['monthly_salary'],
    $loan_type,
    $loan_terms,
    $loan_amount,
    $purpose,
    $valid_id_path,
    $proof_income_path,
    $coe_path,
    $monthly_payment,
    $due_date
);

if ($stmt->execute()) {
    header("Location: index.php?message=Loan submitted successfully!");
} else {
    echo "Error: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>