<?php
include 'db.php';

$sql = "SELECT * FROM food_items ORDER BY food_id DESC";
$result = $conn->query($sql);

if ($result === false) {
    // If there was an issue with the query
    echo json_encode(["error" => "SQL Query Failed: " . $conn->error]);
    exit();
}

$items = [];
while ($row = $result->fetch_assoc()) {
    $items[] = $row;
}

echo json_encode($items);
$conn->close();
?>
