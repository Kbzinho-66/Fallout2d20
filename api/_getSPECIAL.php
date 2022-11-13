<?php

$character_id = $_GET['id'];

$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$stmt = $conn->prepare('SELECT * FROM special_attributes WHERE character_id = ?');
$stmt->bind_param('i', $character_id);
$stmt->execute();

$result = $stmt->get_result();
$info   = $result->fetch_assoc();

exit(json_encode($info));
