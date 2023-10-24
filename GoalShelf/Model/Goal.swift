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
    mutating func toggle(_ task:Task) {
        let index:Int? = tasks.firstIndex{$0.id == task.id}
        if(index != nil)
        {
            tasks[index!].isCompleted.toggle()
        }
    }
    //add time variable
}

enum GoalEnum : String{
    case education = "Education"
    case work = "Work"
    case health = "Health"
    case special = "Special"
    
    var symbol: String {
        switch self {
        case .education:
            "books.vertical"
        case .work:
            "bag"
        case .health:
            "leaf"
        case .special:
            "fireworks"
        }
    }
    var colors: [Color] {
        switch self {
        case .education:
            [Color.lightEducation, Color.strongEducation]
        case .work:
            [Color.lightWork, Color.strongWork]
        case .health:
            [Color.lightHealth, Color.strongHealth]
        case .special:
            [.red,.orange,.yellow,.green,.blue,.purple]
        }
    }
}
