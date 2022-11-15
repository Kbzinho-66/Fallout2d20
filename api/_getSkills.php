<?php

$character_id = $_GET['id'];

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$stmt1 = $conn->prepare('SELECT * FROM skills WHERE character_id = ?;');
$stmt1->bind_param('i', $character_id);
$stmt1->execute();
$skills = $stmt1->get_result()->fetch_assoc();

$stmt2 = $conn->prepare('SELECT * FROM `tagged-skills` WHERE character_id = ?;');
$stmt2->bind_param('i', $character_id);
$stmt2->execute();
$tagged = $stmt2->get_result()->fetch_assoc();

$info = [];
foreach($skills as $name => $rank) {
    if ($name == 'character_id') continue;
    $arr = array(
        'tagged' => $tagged[$name] == 1,
        'rank'   => $rank
    );
    $info[$name] = $arr;
}

exit(json_encode($info));
