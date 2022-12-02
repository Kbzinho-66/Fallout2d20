<?php

$data = json_decode(file_get_contents('php://input'), true);

$id = $data['id'];

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

if (isset($data['ap'])) {
    $ap = $data['ap'];
    $stmt = $conn->prepare('UPDATE characters
                                    SET action_points = ?
                                    WHERE character_id = ?;');
    $stmt->bind_param('ii', $ap, $id);
} elseif (isset($data['lp'])) {
    $lp = $data['lp'];
    $stmt = $conn->prepare('UPDATE characters
                                    SET luck_points = ?
                                    WHERE character_id = ?;');
    $stmt->bind_param('ii', $lp, $id);
} elseif (isset($data['hp'])) {
    $hp = $data['hp'];
    $stmt = $conn->prepare('UPDATE characters
                                    SET health_points = ?
                                    WHERE character_id = ?;');
    $stmt->bind_param('ii', $hp, $id);
}

if (isset($stmt)) {
    $stmt->execute();
    mysqli_close($conn);
    exit(json_encode($stmt));
}
