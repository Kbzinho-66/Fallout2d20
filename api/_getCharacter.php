<?php

$conn = mysqli_connect('localhost', 'Gabriel', 'BigIron', 'Fallout2d20');

$query = mysqli_query($conn, "SELECT * from characters where character_id = 1");

$result = mysqli_fetch_assoc($query);

exit(json_encode($result));
