<?php

$level = $_GET['level'];

$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$stmt = $conn->prepare('SELECT * FROM levels WHERE level = ?');
$stmt->bind_param('i', $level);
$stmt->execute();

$result = $stmt->get_result();
$info   = $result->fetch_assoc();

exit(json_encode($info));
