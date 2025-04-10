//
//  TempPlayerData.swift
//  JourneyOfMidnight
//
//  Created by Hualiteq International on 2025/3/31.
//

import Foundation

var tempPlayerCardSet1 = [
    Hero(
        heroClass:
            HeroClass(name: .wizard, level: 10),
        attributes:
            Attributes(
                Strength: 2, 
                Intelligence: 15,
                Wisdom: 20,
                Agility: 8,
                Vitality: 5,
                Faith: 6,
                Charisma: 15),
        skills: [
            Skill(name: "Freeze Breeze"), 
            Skill(name: "Dark Blossom")],
        items: [
            Item(name: "Ancient Wand"),
            Item(name: "Lost Myth")],
        stats:
            Stats(health: 100, endurance: 800)),
//    Hero(
//        heroClass:
//            HeroClass(name: .priest, level: 10),
//        attributes:
//            Attributes(
//                Strength: 2,
//                Intelligence: 10,
//                Wisdom: 14,
//                Agility: 10,
//                Vitality: 10,
//                Faith: 20,
//                Charisma: 8),
//        skills: [
//            Skill(name: "Holy Call"),
//            Skill(name: "Sins Recall")],
//        items: [
//            Item(name: "Ancient Bible"),
//            Item(name: "Saint Golden Cup")],
//        stats:
//            Stats(health: 100, endurance: 800))
    
]

var tempPlayer1 = [
    Character(
        name: "WolfGuardiance",
        type: .follower,
        ability:[
            Ability(skillName: "TitanS", boxAmt: 1, skillType: .Attack),
            Ability(skillName: "Gnslngr", boxAmt: 1, skillType: .Defense)
        ]
    ),
    Character(
        name: "KiityEnemy",
        type: .hero,
        ability:[
            Ability(skillName: "Angl", boxAmt: 1, skillType: .Attack),
            Ability(skillName: "Holy", boxAmt: 1, skillType: .Defense),
            Ability(skillName: "Freez", boxAmt: 1, skillType: .Heal)]
    ),
    Character(
        name: "WolfGuardiance",
        type: .follower,
        ability:[
            Ability(skillName: "Titan S", boxAmt: 1, skillType: .Attack),
            Ability(skillName: "Gnslngr", boxAmt: 1, skillType: .Defense)]
    ),
]
var tempPlayer2 = [
    Character(
        name: "Meowster",
        type: .follower,
        ability:[
            Ability(skillName: "TitanS", boxAmt: 1, skillType: .Attack),
            Ability(skillName: "Gnslngr", boxAmt: 1, skillType: .Attack)]
    ),
    Character(
        name: "Meowster",
        type: .follower,
        ability:[
            Ability(skillName: "TitanS", boxAmt: 1, skillType: .Heal),
            Ability(skillName: "Gnslngr", boxAmt: 1, skillType: .Attack)]
    ),
    Character(
        name: "WolfCommander",
        type: .hero,
        ability:[
            Ability(skillName: "Angl", boxAmt: 1, skillType: .Attack),
            Ability(skillName: "Meow", boxAmt: 1, skillType: .Heal),
            Ability(skillName: "🖤", boxAmt: 1, skillType: .Attack)]
    ),
    Character(
        name: "Meowster",
        type: .follower,
        ability:[
            Ability(skillName: "TitanS", boxAmt: 1, skillType: .Attack),
            Ability(skillName: "Gnslngr", boxAmt: 1, skillType: .Defense)]
    ),
    Character(
        name: "Meowster",
        type: .follower,
        ability:[
            Ability(skillName: "TitanS", boxAmt: 1, skillType: .Attack),
            Ability(skillName: "Gnslngr", boxAmt: 1, skillType: .Heal)]
    ),
]


