<?php
session_start();
date_default_timezone_set('Asia/Manila');
header('Content-Type: application/json');

if (!isset($_SESSION['user_email']) || ($_SESSION['user_role'] ?? '') !== 'admin') {
    http_response_code(403);
    echo json_encode(['success' => false, 'error' => 'Access denied']);
    exit;
}

$host = "localhost";
$user = "root";
$pass = "";
$db = "loan_system";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'error' => 'DB connection failed']);
    exit;
}

$input = json_decode(file_get_contents("php://input"), true);
$loan_id = isset($input['loan_id']) ? (int)$input['loan_id'] : 0;
$status = trim($input['status'] ?? '');
$remarks = trim($input['remarks'] ?? '');

if ($loan_id <= 0) {
    echo json_encode(['success' => false, 'error' => 'Invalid loan ID']);
    exit;
}

if (!in_array($status, ['Active', 'Rejected'])) {
    echo json_encode(['success' => false, 'error' => 'Invalid status']);
    exit;
}

$admin_name = $_SESSION['user_name'] ?? 'Admin';
$timestamp = date('Y-m-d H:i:s');

if ($status === 'Active') {
    // Calculate next payment due date (1 month from now)
    $next_payment_due = date('Y-m-d', strtotime('+1 month'));
    
    // Approval: set approved fields, clear rejection fields
    $stmt = $conn->prepare("
        UPDATE loan_applications 
        SET status = ?, remarks = ?, 
            approved_by = ?, approved_at = ?,
            next_payment_due = ?,
            rejected_by = NULL, rejected_at = NULL, rejection_remarks = NULL
        WHERE id = ?
    ");
    $stmt->bind_param("sssssi", $status, $remarks, $admin_name, $timestamp, $next_payment_due, $loan_id);
} else {
    // Rejection: set rejected fields, clear approval fields
    $stmt = $conn->prepare("
        UPDATE loan_applications 
        SET status = ?, remarks = ?, 
            rejected_by = ?, rejected_at = ?, rejection_remarks = ?,
            approved_by = NULL, approved_at = NULL, next_payment_due = NULL
        WHERE id = ?
    ");
    $stmt->bind_param("sssssi", $status, $remarks, $admin_name, $timestamp, $remarks, $loan_id);
}

if (!$stmt) {
    echo json_encode(['success' => false, 'error' => 'Prepare failed']);
    exit;
}

if ($stmt->execute()) {
    echo json_encode([
        'success' => true,
        'message' => 'Status updated',
        'new_status' => $status,
        'new_remarks' => $remarks
    ]);
} else {
    echo json_encode(['success' => false, 'error' => 'Update failed']);
}

$stmt->close();
$conn->close();
?>