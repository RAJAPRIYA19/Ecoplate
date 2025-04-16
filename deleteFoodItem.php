<?php
include 'dbUtil.php'; // Must be in the same folder

if (isset($_GET['id'])) {
    $id = $_GET['id'];

    $conn = getDbConnection();

    $stmt = $conn->prepare("DELETE FROM food_items WHERE food_id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();

    echo json_encode(["status" => "success"]);
    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["status" => "failed", "reason" => "No ID provided"]);
}
?>
