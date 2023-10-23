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
    var type: goalEnum //to change to enum
    var name:String
    var description:String
    var tasks: [Task]
    
    //add time variable
}

enum goalEnum : String{
    case education = "Education"
    case work = "Work"
    case health = "Health"
    case special = "Special"
}

var colorMap: [goalEnum: [Color]] = [
    goalEnum.education : [Color.lightEducation, Color.strongEducation],
    goalEnum.work : [Color.lightWork, Color.strongWork],
    goalEnum.health : [Color.lightHealth, Color.strongHealth],
    goalEnum.special : [.red,.orange,.yellow,.green,.blue,.purple]
    ]

var symbolMap: [goalEnum: String] = [
    goalEnum.education : "vertical.books",
    goalEnum.work : "bag",
    goalEnum.health : "leaf",
    goalEnum.special : "fireworks"
]
