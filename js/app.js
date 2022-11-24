import Character from "./Character.js";

// Obviamente, seria melhor pegar o id do banco de dados de alguma forma, mas não vai
// dar tempo de implementar isso porque teria que fazer algo com usuário.
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

      char.getSkills().then( () => {
        const camelToSnake = function(name) {
          return name.replace(
              /[A-Z]/g,
              char => `_${char.toLowerCase()}`
          );
        };

        for (const camel of Object.keys(char.skills)) {
          //  No objeto, as chaves tão em camelCase, mas precisa em snake_case pra acessar o HTML
          const snake = camelToSnake(camel);

          document.getElementById(`${snake}_tagged`).checked = char.skills[camel].tagged;
          document.getElementById(`${snake}_rank`).innerHTML = char.skills[camel].rank;
        }
        updateSkillsTarget();

        char.getWeapons().then( () => {
          if (char.weapons.length) {
            const weaponAttributes = {
              'Melee Weapons' : { short: 'str', full: 'strength'  , skill: 'meleeWeapons' },
              'Small Guns'    : { short: 'agi', full: 'agility'   , skill: 'smallGuns' },
              'Big Guns'      : { short: 'end', full: 'endurance' , skill: 'bigGuns' },
              'Energy Weapons': { short: 'per', full: 'perception', skill: 'energyWeapons' },
              'Explosives'    : { short: 'per', full: 'perception', skill: 'explosives' },
              'Throwing'      : { short: 'agi', full: 'agility'   , skill: 'throwing' },
              'Unarmed'       : { short: 'str', full: 'strength'  , skill: 'unarmed' },
            };

            const table = document.getElementById('weapon_list').getElementsByTagName('tbody')[0];
            for (const weapon of char.weapons) {
              const newRow = table.insertRow();
              newRow.classList.add('item_row');
              let value;

              const nameCell = newRow.insertCell();
              nameCell.classList.add('table_text');
              value = document.createTextNode(weapon['weapon_name']);
              nameCell.appendChild(value);

              const attrCell = newRow.insertCell();
              const weaponType = weapon['weapon_type'];
              const shortStat = weaponAttributes[weaponType].short;
              const attrSpan = document.createElement('span');
              attrSpan.classList.add('badge', `${shortStat}_attr`, 'rounded-pill');
              attrSpan.innerHTML = shortStat.toUpperCase();
              attrCell.appendChild(attrSpan);

              const targetCell = newRow.insertCell();
              targetCell.classList.add('table_text');
              const completeStat = weaponAttributes[weaponType].full;
              const skill = weaponAttributes[weaponType].skill;
              const target = char.special[completeStat] + char.skills[skill].rank;
              console.log(target);
              value = document.createTextNode(target);
              targetCell.appendChild(value);

              const dmgTypeCell = newRow.insertCell();
              dmgTypeCell.classList.add('table_text');
              value = document.createTextNode(weapon['damage_type']);
              dmgTypeCell.appendChild(value);

              const drCell = newRow.insertCell();
              drCell.classList.add('table_text');
              value = document.createTextNode(weapon['damage_rating']);
              drCell.appendChild(value);

              const fireRateCell = newRow.insertCell();
              fireRateCell.classList.add('table_text');
              value = document.createTextNode(weapon['fire_rate']);
              fireRateCell.appendChild(value);

              const rangeCell = newRow.insertCell();
              rangeCell.classList.add('table_text');
              value = document.createTextNode(weapon['firing_range']);
              rangeCell.appendChild(value);

              const effectsCell = newRow.insertCell();
              effectsCell.classList.add('table_text');
              value = document.createTextNode(weapon['damage_effects'] ?? '-');
              effectsCell.appendChild(value);

              const qualitiesCell = newRow.insertCell();
              qualitiesCell.classList.add('table_text');
              value = document.createTextNode(weapon['q'] ?? '-');
              qualitiesCell.appendChild(value);
            }
          }
        });
      });
    });
  });
});

char.getPerks().then( () => {
  if (char.perks.length) {
    document.getElementById('perk_list').classList.remove('d-none');
    // TODO Idealmente, teria que listar todos os perks aqui, mas com html puro é muito complexo...
  }
});

char.getApparel().then( () => {
  if (char.apparel.length) {
    // document.getElementById('apparel_list').classList.remove('d-none');
    for (const piece of char.apparel) {
      // Mostrar a armadura/roupa
    }
  }
})

/*************************************** FUNÇÕES ***************************************/
//  Percorre cada uma das habilidades e soma o rank com o bônus de SPECIAL selecionado
function updateSkillsTarget() {
  const camelToSnake = function(name) {
    return name.replace(
        /[A-Z]/g,
        char => `_${char.toLowerCase()}`
    );
  };

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
