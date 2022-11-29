
export default class Character {
  constructor(id) {
    this.id            = id;
    this.name          = '';
    this.origin        = '';
    this.currentLevel = 1;

    // Experience Points
    this.xp = {
      current: 0,
      max: -1
    };

    // Actions Points
    this.ap = {
      current: -1,
      max    : 6
    };

    // Luck Points
    this.lp = {
      current: -1,
      max    : -1
    };

    // Health Points
    this.hp = {
      current: -1,
      max    : -1
    };

    // Damage Resistance
    this.dr = {
      head     : {phys: 0, rad: 0, en: 0},
      leftArm : {phys: 0, rad: 0, en: 0},
      torso    : {phys: 0, rad: 0, en: 0},
      rightArm: {phys: 0, rad: 0, en: 0},
      leftLeg : {phys: 0, rad: 0, en: 0},
      rightLeg: {phys: 0, rad: 0, en: 0},
    }

    this.levelStats = {
      skillRanks: 1,
      hpBonus   : 1,
      perks     : 1
    };

    this.special = {
      strength    : -1,
      perception  : -1,
      endurance   : -1,
      charisma    : -1,
      intelligence: -1,
      agility     : -1,
      luck        : -1
    };

    this.attributes = {
      defense   : -1,
      meleeDmg  : -1,
      initiative: -1,
      poisonRes : 0
    };

    this.skills = {
      athletics    : {tagged: false, rank: -1},
      barter       : {tagged: false, rank: -1},
      bigGuns      : {tagged: false, rank: -1},
      energyWeapons: {tagged: false, rank: -1},
      explosives   : {tagged: false, rank: -1},
      lockpick     : {tagged: false, rank: -1},
      medicine     : {tagged: false, rank: -1},
      meleeWeapons : {tagged: false, rank: -1},
      pilot        : {tagged: false, rank: -1},
      repair       : {tagged: false, rank: -1},
      science      : {tagged: false, rank: -1},
      smallGuns    : {tagged: false, rank: -1},
      sneak        : {tagged: false, rank: -1},
      speech       : {tagged: false, rank: -1},
      survival     : {tagged: false, rank: -1},
      throwing     : {tagged: false, rank: -1},
      unarmed      : {tagged: false, rank: -1},
    };

    this.perks = [];

    this.apparel = [];

    this.weapons = [];
  }

  getCharacterInfo() {
    const url = `api/_getCharacter.php?id=${this.id}`;
    return fetch(url)
        .then(res => res.json())
        .then(response => {
          this.name         = response['name'];
          this.origin       = response['origin'];
          this.currentLevel = response['level'];
          this.xp.current   = response['experience'];
          this.ap.current   = response['action_points'];
          this.lp.current   = response['luck_points'];
          this.hp.current   = response['health_points'];
        })
        .catch(console.error);
  }

  getLevelStats() {
    const url = `api/_getLevelStats.php?level=${this.currentLevel}`;
    return fetch(url)
        .then( res => res.json() )
        .then( response => {
          this.xp.max                = response['xp'];
          this.levelStats.hpBonus    = response['hp_bonus'];
          this.levelStats.perks      = response['perks'];
          this.levelStats.skillRanks = response['skill_ranks'];
        })
        .catch(console.error);
  }

  getSPECIAL() {
    const url = `api/_getSPECIAL.php?id=${this.id}`;
    return fetch(url)
        .then( res => res.json() )
        .then( response => {
          const str = response['strength'];
          const per = response['perception'];
          const end = response['endurance'];
          const cha = response['charisma'];
          const int = response['intelligence'];
          const agi = response['agility'];
          const lck = response['luck'];

          this.special.strength     = str;
          this.special.perception   = per;
          this.special.endurance    = end;
          this.special.charisma     = cha;
          this.special.intelligence = int;
          this.special.agility      = agi;
          this.special.luck         = lck;

          // Calcular os atributos que já dá pra calcular
          this.lp.max = lck;
          this.attributes.initiative = per * 2;
          this.attributes.defense = agi >= 8 ? 2 : 1;
          if (str < 7) {
            this.attributes.meleeDmg = 0;
          } else if (str < 9) {
            this.attributes.meleeDmg = 1;
          } else if (str < 11) {
            this.attributes.meleeDmg = 2;
          } else {
            this.attributes.meleeDmg = 3;
          }
          this.hp.max = end + lck + this.levelStats.hpBonus * end;
        })
        .catch(console.error);
  }

  getSkills() {
    const url = `api/_getSkills.php?id=${this.id}`;
    return fetch(url)
        .then( res => res.json() )
        .then( response => {
          const snakeToCamel = function(snake) {
            return snake.replace(
                /(?!^)_(.)/g,
                (_, char) => char.toUpperCase());
          }

          for (const key of Object.keys(response)) {
            // O nome dos campos vem em snake_case do Banco de Dados, mas tá em camelCase no objeto
            const camel = snakeToCamel(key);

            const tagged = response[key].tagged;
            this.skills[camel].tagged = tagged;
            this.skills[camel].rank   = response[key].rank + (tagged ? 2 : 0);
          }
        })
        .catch(console.error);
  }

  getPerks() {
    const url = `api/_getPerks.php?id=${this.id}`;
    return fetch(url)
        .then( res => res.json() )
        .then( response => {
          for (const perk of response) {
            this.perks.push(perk);
          }
        })
        .catch(console.error)
  }

  getWeapons() {
    const url = `api/_getWeapons.php?id=${this.id}`;
    return fetch(url)
        .then( res => res.json() )
        .then( response => {
          for (const weapon of response) {
            this.weapons.push(weapon);
          }
        })
        .catch(console.error);
  }

  getApparel() {
    const url = `api/_getApparel.php?id=${this.id}`;
    return fetch(url)
        .then( res => res.json() )
        .then( response => {
          for (const piece of response) {
            const phys_dr = piece['physical_dr'];
            const rad_dr  = piece['radiation_dr'];
            const en_dr   = piece['energy_dr'];

            this.apparel.push({
              apparel_id  : piece['apparel_id'],
              name        : piece['name'],
              type        : piece['type'],
              cost        : piece['cost'],
              physical_dr : phys_dr,
              radiation_dr: rad_dr,
              energy_dr   : en_dr,
              covers      : {
                head      : Boolean(piece['head']),
                leftArm  : Boolean(piece['left_arm']),
                torso     : Boolean(piece['torso']),
                rightArm : Boolean(piece['right_arm']),
                leftLeg  : Boolean(piece['left_leg']),
                rightLeg : Boolean(piece['right_leg'])
              }
            });

            if (piece['head']) {
              this.dr.head.phys += phys_dr;
              this.dr.head.rad  += rad_dr;
              this.dr.head.en   += en_dr;
            }

            if (piece['left_arm']) {
              this.dr.leftArm.phys += phys_dr;
              this.dr.leftArm.rad  += rad_dr;
              this.dr.leftArm.en   += en_dr;
            }

            if (piece['torso']) {
              this.dr.torso.phys += phys_dr;
              this.dr.torso.rad  += rad_dr;
              this.dr.torso.en   += en_dr;
            }

            if (piece['right_arm']) {
              this.dr.rightArm.phys += phys_dr;
              this.dr.rightArm.rad  += rad_dr;
              this.dr.rightArm.en   += en_dr;
            }

            if (piece['left_leg']) {
              this.dr.leftLeg.phys += phys_dr;
              this.dr.leftLeg.rad  += rad_dr;
              this.dr.leftLeg.en   += en_dr;
            }

            if (piece['right_leg']) {
              this.dr.rightLeg.phys += phys_dr;
              this.dr.rightLeg.rad  += rad_dr;
              this.dr.rightLeg.en   += en_dr;
            }

          }
        })
        .catch(console.error);
  }

  getSpecialAttribute(special) {
    switch (special.toLowerCase()) {
      case 'str':
      case 'strength':
        return this.special.strength;
      case 'per':
      case 'perception':
        return this.special.perception;
      case 'end':
      case 'endurance':
        return this.special.endurance;
      case 'cha':
      case 'charisma':
        return this.special.charisma;
      case 'int':
      case 'intelligence':
        return this.special.intelligence;
      case 'agi':
      case 'agility':
        return this.special.agility;
      case 'lck':
      case 'luck':
        return this.special.luck;
      default:
        return '';
    }
  }

  getSkillRank(skill) {
    switch (skill) {
      case 'athletics':
        return this.skills.athletics.rank;
      case 'barter':
        return this.skills.barter.rank;
      case 'bigGuns':
      case 'big_guns':
        return this.skills.bigGuns.rank;
      case 'energyWeapons':
      case 'energy_weapons':
        return this.skills.energyWeapons.rank;
      case 'explosives':
        return this.skills.explosives.rank;
      case 'lockpick':
        return this.skills.lockpick.rank;
      case 'medicine':
        return this.skills.medicine.rank;
      case 'meleeWeapons':
      case 'melee_weapons':
        return this.skills.meleeWeapons.rank;
      case 'pilot':
        return this.skills.pilot.rank;
      case 'repair':
        return this.skills.repair.rank;
      case 'science':
        return this.skills.science.rank;
      case 'smallGuns':
      case 'small_guns':
        return this.skills.smallGuns.rank;
      case 'sneak':
        return this.skills.sneak.rank;
      case 'speech':
        return this.skills.speech.rank;
      case 'survival':
        return this.skills.survival.rank;
      case 'throwing':
        return this.skills.throwing.rank;
      case 'unarmed':
        return this.skills.unarmed.rank;
    }
  }
}