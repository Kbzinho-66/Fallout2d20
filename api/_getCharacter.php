<?php

$character_id = $_GET['id'];

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$stmt = $conn->prepare('SELECT * FROM characters WHERE character_id = ?;');
$stmt->bind_param('i', $character_id);
$stmt->execute();

$result = $stmt->get_result();
$info   = $result->fetch_assoc();

mysqli_close($conn);

exit(json_encode($info));
