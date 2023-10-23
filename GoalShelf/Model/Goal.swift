//
//  Goal.swift
//  GoalShelf
//
//  Created by Giuseppe Casillo on 22/10/23.
//

import Foundation
import SwiftUI

struct Goal: Identifiable{
    let id = UUID()
    var type: GoalEnum
    var name:String
    var description:String
    var tasks: [Task]
    
    //add time variable
}

enum GoalEnum : String{
    case education = "Education"
    case work = "Work"
    case health = "Health"
    case special = "Special"
}

var colorMap: [GoalEnum: [Color]] = [
    GoalEnum.education : [Color.lightEducation, Color.strongEducation],
    GoalEnum.work : [Color.lightWork, Color.strongWork],
    GoalEnum.health : [Color.lightHealth, Color.strongHealth],
    GoalEnum.special : [.red,.orange,.yellow,.green,.blue,.purple]
    ]

var symbolMap: [GoalEnum: String] = [
    GoalEnum.education : "vertical.books",
    GoalEnum.work : "bag",
    GoalEnum.health : "leaf",
    GoalEnum.special : "fireworks"
]
