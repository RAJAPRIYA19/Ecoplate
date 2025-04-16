<?php
function getDbConnection() {
    $host = "localhost";
    $user = "root";
    $password = "P1r2i3y4a5.";
    $dbname = "ecoplate"; // use your actual DB name

    $conn = new mysqli($host, $user, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    return $conn;
}
?>
