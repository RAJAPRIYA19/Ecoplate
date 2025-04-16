<?php
session_start();
header('Content-Type: application/json');

$username = $_SESSION['username'] ?? null;

if (!$username) {
    echo json_encode([]);
    exit();
}

$conn = new mysqli("localhost", "root", "P1r2i3y4a5.", "ecoplate");
if ($conn->connect_error) {
    die(json_encode(["error" => "Database connection failed."]));
}

$sql = "SELECT id, food_name, status FROM orders WHERE recipient_username=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

$orders = [];
while ($row = $result->fetch_assoc()) {
    $orders[] = $row;
}

$stmt->close();
$conn->close();

echo json_encode($orders);
