//
//  Goal.swift
//  firstapp
//
//  Created by Giuseppe Casillo on 22/10/23.
//

import Foundation

struct Goal: Identifiable{
    var id = UUID()
    var type: String
    var name: String
    var description: String
    var tasks: [Task]
    
    //add time variable
}
