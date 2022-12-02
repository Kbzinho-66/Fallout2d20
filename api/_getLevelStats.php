<?php

$level = $_GET['level'];

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$stmt = $conn->prepare('SELECT * FROM levels WHERE level = ?;');
$stmt->bind_param('i', $level);
$stmt->execute();

$result = $stmt->get_result();
$info   = $result->fetch_assoc();

mysqli_close($conn);

exit(json_encode($info));
