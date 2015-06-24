<?php
$servername = "localhost";
$username = "osama";
$password = "4t6ZsSqZp5tceqKU";

// Create connection
$conn = new mysqli($servername, $username, $password, 'osama_db');

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

?>