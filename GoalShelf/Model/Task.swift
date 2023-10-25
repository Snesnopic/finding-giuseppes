//
//  Task.swift
//  firstapp
//
//  Created by Giuseppe Casillo on 22/10/23.
//

import Foundation
import SwiftData

struct Task: Codable, Identifiable {
    var id = UUID()
    var name:String = ""
    var description:String  = ""
    var isCompleted:Bool = false
    var repetitionCount:Int = 1 //how many times a week
    var repetitionPermanence:Int = 1 //how many weeks
    //add repeatability
}
