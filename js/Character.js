
export default class Character {
  constructor(id) {
    this.id            = id;
    this.name          = '';
    this.origin        = '';
    this.currentLevel = 1;

    this.xp = {
      current: 0,
      max: -1
    };

    this.ap = {
      current: -1,
      max    : 6
    };

    this.lp = {
      current: -1,
      max    : -1
    };

    this.hp = {
      current: -1,
      max    : -1
    };

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
      poisonRes : -1
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

    this.perks = [
      {name: '', rank: -1, maxRank: -1, description: '...'},
    ];

    this.apparel = [
      {
        name       : '',
        physicalDR : -1,
        radiationDR: -1,
        energyDR   : -1,
        covers     : {
          head     : false,
          leftArm  : false,
          torso    : false,
          rightArm : false,
          leftLeg  : false,
          rightLeg : false
        }
      },
    ];

    this.weapons = [
      {
        name     : '',
        attr     : '',
        target   : -1,
        dmgType  : '',
        dmgRating: -1,
        fireRate : -1,
        range    : '',
        effects  : [
          {name  : '', description: '...'},
        ],
        qualities: []
      }
    ]
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
          console.log(this);
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


}