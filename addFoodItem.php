<?php
// Start session and enable error reporting for debugging
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Connect to DB
$mysqli = new mysqli("localhost", "root", "P1r2i3y4a5.", "ecoplate");

// Check DB connection
if ($mysqli->connect_errno) {
    echo json_encode(['success' => false, 'message' => 'Failed to connect to database']);
    exit;
}

// Get JSON input
$inputData = json_decode(file_get_contents('php://input'), true);

// Validate required fields
if (isset($inputData['food_name'], $inputData['description'], $inputData['quantity'], $inputData['unit'], $inputData['expiry_date'], $inputData['location_to_pickup'], $inputData['price'], $inputData['place_of_creation'])) {

    // Sanitize input
    $food_name = $inputData['food_name'];
    $description = $inputData['description'];
    $quantity = $inputData['quantity'];
    $unit = $inputData['unit'];
    $expiry_date = $inputData['expiry_date'];
    $location_to_pickup = $inputData['location_to_pickup'];
    $price = $inputData['price'];
    $place_of_creation = $inputData['place_of_creation'];

    // Insert without user_id
    $sql = "INSERT INTO food_items (food_name, description, quantity, unit, expiry_date, location_to_pickup, price, place_of_creation) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("sssssids", $food_name, $description, $quantity, $unit, $expiry_date, $location_to_pickup, $price, $place_of_creation);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Food item added successfully']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to add food item: ' . $stmt->error]);
    }

    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Missing required fields']);
}
?>
