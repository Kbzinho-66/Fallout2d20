
getCharacterInfo(1);

function getCharacterInfo(character_id) {
  const url = `api/_getCharacter.php?id=${character_id}`;
  fetch(url)
      .then( (res) => res.json())
      .then(response => {
        document.getElementById('character-name').innerHTML = response['name'];

        document.getElementById('origin-field').innerHTML = response['origin'];

        document.getElementById('current-level').value = `Level ${response['level']}`;
        document.getElementById('current-xp').value = response['experience'];

        document.getElementById('current-ap').value = response['action_points'];
        document.getElementById('current-lp').value = response['luck_points'];
        document.getElementById('current-hp').value = response['health_points'];
      })
      .catch(error => {
        console.error(error);
      })
}

