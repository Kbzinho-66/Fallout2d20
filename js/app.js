import Character from "./Character.js";

// Obviamente, seria melhor pegar o id do banco de dados de alguma forma,
// mas não vai dar tempo de implementar isso porque teria que fazer algo com usuário.
const char = new Character(1);

char.getCharacterInfo().then(() => {
  char.getLevelStats().then(() => {
    char.getSPECIAL().then(() => {
      renderBasicStats();
      renderSpecialStats();

      char.getSkills().then(() => {
        renderSkills();

        char.getWeapons().then(() => {
          renderWeapons();
        });
      });
    });
  });
});

char.getPerks().then(() => {
  renderPerks();
});

char.getApparel().then(() => {
  renderApparel();
})

// TODO Teria que trazer a imagem do personagem do banco também. Isso se de fato vai ter imagem...

// Preparar o select pra alterar o target da skill relevante
const selects = document.getElementsByClassName('attr_select');
for (const select of selects) {
  select.onchange = (event) => {
    const t       = event.target;
    const text    = t.value;
    const id      = t.id;
    t.className   = t.className.replace(/(str|per|end|cha|int|agi|lck)/, text);
    updateSingleSkill(id, text);
  }
}

// Colocar um controle de XP pra levar pra página de Level Up
document.getElementById('current_xp').onchange = event => {
  const currXp = event.target.value;
  void char.updateXP(currXp);
  if (currXp >= char.xp.max) {
    document.getElementById('level_up_link').classList.remove('d-none');
  } else {
    document.getElementById('level_up_link').classList.add('d-none')
  }
}

// Mudanças de AP, LP e HP só devem ir pro banco de dados depois de uns segundos sem mudanças
document.getElementById('current_ap').onchange = debounce( event => char.update('ap', event.target.value) );
document.getElementById('current_lp').onchange = debounce( event => char.update('lp', event.target.value) );
document.getElementById('current_hp').onchange = debounce( event => char.update('hp', event.target.value) );

/******************************* FUNÇÕES DE RENDERIZAÇÃO *******************************/
function renderBasicStats() {
  document.getElementById('character_name').innerHTML = char.name;
  document.getElementById('origin_field').innerHTML   = char.origin;
  document.getElementById('current_level').innerHTML  = `Level ${char.currentLevel}`;
  document.getElementById('current_xp').value         = char.xp.current;
  document.getElementById('current_ap').value         = char.ap.current;
  document.getElementById('current_lp').value         = char.lp.current;
  document.getElementById('current_hp').value         = char.hp.current;
  document.getElementById('max_xp').innerHTML         = char.xp.max;
  document.getElementById('max_lp').innerHTML         = char.lp.max;
  document.getElementById('melee_dmg').innerHTML      = char.attributes.meleeDmg;
  document.getElementById('initiative').innerHTML     = char.attributes.initiative;
  document.getElementById('poison_dr').innerHTML      = char.attributes.poisonRes;
  document.getElementById('max_hp').innerHTML         = char.hp.max;
}

function renderSpecialStats() {
  document.getElementById('str_value').innerHTML = char.special.strength;
  document.getElementById('per_value').innerHTML = char.special.perception;
  document.getElementById('end_value').innerHTML = char.special.endurance;
  document.getElementById('cha_value').innerHTML = char.special.charisma;
  document.getElementById('int_value').innerHTML = char.special.intelligence;
  document.getElementById('agi_value').innerHTML = char.special.agility;
  document.getElementById('lck_value').innerHTML = char.special.luck;

  const names = {
    str: 'strength',
    per: 'perception',
    end: 'endurance',
    cha: 'charisma',
    int: 'intelligence',
    agi: 'agility',
    lck: 'luck'
  };

  // Coloca o bônus equivalente a cada atributo SPECIAL
  for (const [short, full] of Object.entries(names)) {
    for (const elem of document.getElementsByClassName(`${short}_bonus`)) {
      elem.innerHTML = char.special[full];
    }
  }

}

function renderSkills() {
  // TODO Teria que trazer o atributo default do banco de dados pra não depender só do HTML
  for (const camel of Object.keys(char.skills)) {
    //  No objeto, as chaves tão em camelCase, mas precisa em snake_case pra acessar o HTML
    const snake = camelToSnake(camel);

    document.getElementById(`${snake}_tagged`).checked = char.skills[camel].tagged;
    document.getElementById(`${snake}_rank`).innerHTML = char.skills[camel].rank;
  }
  updateSkillsTarget();
}

function renderWeapons() {
  if (char.weapons.length) {
    const weaponAttributes = {
      'Melee Weapons' : {short: 'str', full: 'strength'  , skill: 'meleeWeapons'},
      'Small Guns'    : {short: 'agi', full: 'agility'   , skill: 'smallGuns'},
      'Big Guns'      : {short: 'end', full: 'endurance' , skill: 'bigGuns'},
      'Energy Weapons': {short: 'per', full: 'perception', skill: 'energyWeapons'},
      'Explosives'    : {short: 'per', full: 'perception', skill: 'explosives'},
      'Throwing'      : {short: 'agi', full: 'agility'   , skill: 'throwing'},
      'Unarmed'       : {short: 'str', full: 'strength'  , skill: 'unarmed'},
    };

    const table = document.getElementById('weapon_list').getElementsByTagName('tbody')[0];
    for (const weapon of char.weapons) {
      const newRow = table.insertRow();
      newRow.classList.add('item_row');
      let value;

      const weaponType   = weapon['weapon_type'];
      const shortStat    = weaponAttributes[weaponType].short;
      const completeStat = weaponAttributes[weaponType].full;
      const skill        = weaponAttributes[weaponType].skill;

      const nameCell = newRow.insertCell();
      nameCell.classList.add('table_text');
      value = document.createTextNode(weapon['weapon_name']);
      nameCell.appendChild(value);

      const attrCell = newRow.insertCell();
      const attrSpan = document.createElement('span');
      attrSpan.classList.add('badge', `${shortStat}_attr`, 'rounded-pill');
      attrSpan.innerHTML = shortStat.toUpperCase();
      attrCell.appendChild(attrSpan);

      const targetCell = newRow.insertCell();
      targetCell.classList.add('table_text');
      const target = char.getSpecialAttribute(completeStat) + char.skills[skill].rank;
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
}

function renderPerks() {
  if (char.perks.length) {
    document.getElementById('perk_list').classList.remove('d-none');
    // TODO Idealmente, teria que listar todos os perks aqui, mas com html puro é muito complexo...
  }
}

function renderApparel() {
  if (char.apparel.length) {
    const table = document.getElementById('apparel_list').getElementsByTagName('tbody')[0];
    for (const piece of char.apparel) {
      const newRow = table.insertRow();
      newRow.classList.add('item_row');
      let value;

      const nameCell = newRow.insertCell();
      nameCell.classList.add('table_text');
      value = document.createTextNode(piece['name']);
      nameCell.appendChild(value);

      const physicalDRCell = newRow.insertCell();
      physicalDRCell.classList.add('table_text');
      value = document.createTextNode(piece['physical_dr']);
      physicalDRCell.appendChild(value);

      const radiationDRCell = newRow.insertCell();
      radiationDRCell.classList.add('table_text');
      value = document.createTextNode(piece['radiation_dr']);
      radiationDRCell.appendChild(value);

      const energyDRCell = newRow.insertCell();
      energyDRCell.classList.add('table_text');
      value = document.createTextNode(piece['energy_dr']);
      energyDRCell.appendChild(value);

      const partsCell = newRow.insertCell();
      partsCell.classList.add('table_text');
      let partsString = '';
      if (piece.covers.head) partsString += 'Head, ';

      if (piece.covers.leftArm && piece.covers.rightArm) partsString += 'Arms, ';
      else if (piece.covers.leftArm) partsString += 'Left Arm, ';
      else partsString += 'Right Arm, ';

      if (piece.covers.torso) partsString += 'Torso, ';

      if (piece.covers.leftLeg && piece.covers.rightLeg) partsString += 'Legs, ';
      else if (piece.covers.leftLeg) partsString += 'Left Leg, ';
      else partsString += 'Right Leg, ';

      value = document.createTextNode(partsString.slice(0, -2));
      partsCell.appendChild(value);
    }

    for (const bodyPart of Object.keys(char.dr)) {
      for (const dr_type of Object.keys(char.dr[bodyPart])) {
        const htmlId = camelToSnake(bodyPart) + '_' + camelToSnake(dr_type) + '_dr';
        document.getElementById(htmlId).innerHTML = char.dr[bodyPart][dr_type];
      }
    }
  }
}


/********************************* FUNÇÕES DE UTILIDADE *********************************/
//  Percorre cada uma das habilidades e soma o rank com o bônus de SPECIAL selecionado
function updateSkillsTarget() {
  for (const camel of Object.keys(char.skills)) {
    const snake = camelToSnake(camel);

    const selectedSpecial = document.getElementById(`${snake}_selected`).value;
    const specialAttr = char.getSpecialAttribute(selectedSpecial);
    const skillTarget = char.skills[camel].rank + specialAttr;
    document.getElementById(`${snake}_target`).innerHTML = skillTarget;
  }
}

function updateSingleSkill(skill_id, special) {
  const selectedSkill = skill_id.slice(0, skill_id.indexOf('_selected'));
  const skillRank = char.getSkillRank(selectedSkill);
  const specialAttr = char.getSpecialAttribute(special);

  document.getElementById(`${selectedSkill}_special_bonus`).innerHTML = specialAttr;
  document.getElementById(`${selectedSkill}_target`).innerHTML = skillRank + specialAttr;
}

function camelToSnake(name) {
  return name.replace(
      /[A-Z]/g,
      char => `_${char.toLowerCase()}`
  );
}

function debounce(func, timeout = 3000) {
  let timer;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => { func.apply(this, args); }, timeout);
  };
}
