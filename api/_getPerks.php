<?php

$character_id = $_GET['id'];

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$stmt = $conn->prepare('SELECT p.name, perk_rank, p.max_rank, p.description FROM character_perks as c
                              INNER JOIN perks as p on c.perk_id = p.perk_id WHERE c.character_id = ?;');
$stmt->bind_param('i', $character_id);
$stmt->execute();

$res = $stmt->get_result();
$perks = [];
while($perk = $res->fetch_assoc()) {
    $perks[] = $perk;
}

mysqli_close($conn);

exit(json_encode($perks));
