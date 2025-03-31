//
//  TempPlayerData.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/3/31.
//

import Foundation

var tempPlayer1 = [
    Character(name: "WolfGuardiance", type: .follower, ability: abilityFollowerTemp),
    Character(name: "KiityEnemy", type: .hero, ability: abilityHeroTemp),
    Character(name: "WolfGuardiance", type: .follower, ability: abilityFollowerTemp)
]
var tempPlayer2 = [
    Character(name: "Meowster", type: .follower, ability: abilityFollowerTemp),
    Character(name: "Meowster", type: .follower, ability: abilityFollowerTemp),
    Character(name: "WolfCommander", type: .hero, ability: abilityHeroTemp),
    Character(name: "Meowster", type: .follower, ability: abilityFollowerTemp),
    Character(name: "Meowster", type: .follower, ability: abilityFollowerTemp)
]

var abilityHeroTemp = [
    Ability(skillName: "BigSkill", type: .hero),
    Ability(skillName: "MidSkill", type: .hero),
    Ability(skillName: "SmallSkill", type: .hero)
]

var abilityFollowerTemp = [
    Ability(skillName: "FS1", type: .follower),
    Ability(skillName: "FS2", type: .follower)
]
