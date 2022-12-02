<?php

$data = json_decode(file_get_contents('php://input'), true);

$id = $data['id'];
$current_xp = $data['xp'];
$current_lvl = $data['lvl'];

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$stmt = $conn->prepare('UPDATE characters
                                SET experience = ?, level = ?
                                WHERE character_id = ?;');
$stmt->bind_param('iii', $current_xp, $current_lvl, $id);
$stmt->execute();

mysqli_close($conn);
exit(json_encode($stmt));
