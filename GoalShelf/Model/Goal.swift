//
//  Goal.swift
//  GoalShelf
//
//  Created by Giuseppe Casillo on 23/10/23.
//

import Foundation

struct Goal: Identifiable{
    let id = UUID()
    var type:String //to change to enum
    var name:String
    var description:String
    var tasks: [Task]
}
