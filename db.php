<?php
$host = "localhost";
$username = "root";
$password = "P1r2i3y4a5."; // Default for XAMPP
$database = "ecoplate";

$conn = new mysqli($host, $username, $password, $database);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
