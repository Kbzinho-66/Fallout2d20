import Character from "./Character.js";

const char = new Character(1);

char.getCharacterInfo().then( () => {
  document.getElementById('character-name').innerHTML = char.name;
  document.getElementById('origin-field').innerHTML   = char.origin;
  document.getElementById('current-level').innerHTML  = `Level ${char.currentLevel}`;
  document.getElementById('current-xp').value         = char.xp.current;
  document.getElementById('current-ap').value         = char.ap.current;
  document.getElementById('current-lp').value         = char.lp.current;
  document.getElementById('current-hp').value         = char.hp.current;

  char.getLevelStats().then( () => {
    document.getElementById('total-xp').innerHTML = char.xp.max;

    char.getSPECIAL().then( () => {
      document.getElementById('str-stat').innerHTML = char.special.strength ;
      document.getElementById('per-stat').innerHTML = char.special.perception ;
      document.getElementById('end-stat').innerHTML = char.special.endurance ;
      document.getElementById('cha-stat').innerHTML = char.special.charisma ;
      document.getElementById('int-stat').innerHTML = char.special.intelligence ;
      document.getElementById('agi-stat').innerHTML = char.special.agility ;
      document.getElementById('lck-stat').innerHTML = char.special.luck ;

      document.getElementById('total-lp').innerHTML   = char.lp.max;
      document.getElementById('melee_dmg').innerHTML  = char.attributes.meleeDmg;
      document.getElementById('initiative').innerHTML = char.attributes.initiative;
      document.getElementById('total-hp').innerHTML   = char.hp.max;
    })
  })
});


