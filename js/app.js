import Character from "./Character.js";

const char = new Character(1);

char.getCharacterInfo().then( () => {
  document.getElementById('character_name').innerHTML = char.name;
  document.getElementById('origin_field').innerHTML   = char.origin;
  document.getElementById('current_level').innerHTML  = `Level ${char.currentLevel}`;
  document.getElementById('current_xp').value         = char.xp.current;
  document.getElementById('current_ap').value         = char.ap.current;
  document.getElementById('current_lp').value         = char.lp.current;
  document.getElementById('current_hp').value         = char.hp.current;

  char.getLevelStats().then( () => {
    document.getElementById('max_xp').innerHTML = char.xp.max;

    char.getSPECIAL().then( () => {
      document.getElementById('str_value').innerHTML = char.special.strength ;
      document.getElementById('per_value').innerHTML = char.special.perception ;
      document.getElementById('end_value').innerHTML = char.special.endurance ;
      document.getElementById('cha_value').innerHTML = char.special.charisma ;
      document.getElementById('int_value').innerHTML = char.special.intelligence ;
      document.getElementById('agi_value').innerHTML = char.special.agility ;
      document.getElementById('lck_value').innerHTML = char.special.luck ;

      document.getElementById('max_lp').innerHTML     = char.lp.max;
      document.getElementById('melee_dmg').innerHTML  = char.attributes.meleeDmg;
      document.getElementById('initiative').innerHTML = char.attributes.initiative;
      document.getElementById('max_hp').innerHTML     = char.hp.max;

      const names = {
        str : 'strength',
        per : 'perception',
        end : 'endurance',
        cha : 'charisma',
        int : 'intelligence',
        agi : 'agility',
        lck : 'luck'
      };

      // Coloca o bônus equivalente a cada atributo SPECIAL
      for (const [short, full] of Object.entries(names)) {
        for (const elem of document.getElementsByClassName(`${short}_bonus`)) {
          elem.innerHTML = char.special[full];
        }
      }

      updateSkillTarget();
    })
  })
});

char.getSkills().then( () => {
  for (const camel of Object.keys(char.skills)) {
    //  No objeto, as chaves tão em camelCase, mas precisa em snake_case pra acessar o HTML
    const snake = camelToSnake(camel);

    document.getElementById(`${snake}_tagged`).checked = char.skills[camel].tagged;
    document.getElementById(`${snake}_rank`).innerHTML = char.skills[camel].rank;

    updateSkillTarget();
  }
});

//  Percorre cada uma das habilidades e soma o rank com o bônus de SPECIAL selecionado
function updateSkillTarget() {
  const names = {
    str : 'strength',
    per : 'perception',
    end : 'endurance',
    cha : 'charisma',
    int : 'intelligence',
    agi : 'agility',
    lck : 'luck'
  };

  for (const camel of Object.keys(char.skills)) {
    const snake = camelToSnake(camel);

    const selectedSpecial = names[document.getElementById(`${snake}_selected`).value];
    const skillTarget = char.skills[camel].rank + char.special[selectedSpecial];
    document.getElementById(`${snake}_target`).innerHTML = skillTarget;
  }
}

function camelToSnake(name) {
  return name.replace(
      /[A-Z]/g,
      char => `_${char.toLowerCase()}`
  );
}
