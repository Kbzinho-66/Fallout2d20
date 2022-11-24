<?php

$character_id = $_GET['id'];

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$stmt = $conn->prepare('SELECT w.* FROM weapons as w
                              INNER JOIN character_weapons as cw on cw.weapon_id = w.weapon_id
                              WHERE cw.character_id = ?;');
$stmt->bind_param('i', $character_id);
$stmt->execute();

$res = $stmt->get_result();
$weapons = [];
while($weapon = $res->fetch_assoc()) {
    $weapons[] = $weapon;
}

exit(json_encode($weapons));
