<?php

$character_id = $_GET['id'];

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$stmt = $conn->prepare('SELECT a.* FROM apparel as a
                              INNER JOIN character_apparel as ca on ca.apparel_id = a.apparel_id
                              WHERE ca.character_id = ?;');
$stmt->bind_param('i', $character_id);
$stmt->execute();

$res = $stmt->get_result();
$apparel = [];
while($piece = $res->fetch_assoc()) {
    $apparel[] = $piece;
}

exit(json_encode($apparel));
