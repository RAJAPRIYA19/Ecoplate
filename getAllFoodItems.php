<?php
include 'db.php';

header('Content-Type: application/json');

// Use correct column name (e.g., food_id instead of id)
$sql = "SELECT * FROM food_items ORDER BY food_id DESC";
$result = $conn->query($sql);

$items = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $items[] = $row;
    }
}

echo json_encode($items);
$conn->close();
?>
