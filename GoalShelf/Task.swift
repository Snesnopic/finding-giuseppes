//
//  Task.swift
//  GoalShelf
//
//  Created by Giuseppe Casillo on 23/10/23.
//

import Foundation

struct Task: Identifiable{
    let id = UUID()
    var name:String;
    var description:String;
    //add repeatability
}
