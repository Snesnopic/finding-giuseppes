//
//  GoalViewModel.swift
//  firstapp
//
//  Created by Giuseppe Casillo on 22/10/23.
//

import Foundation

class GoalViewModel
{
    var goals = [
        Goal(type: .health, name: "Lose weight", description: "Lose 5kg in 2 months", tasks: []),
        Goal(type: .work, name: "Finish something", description: "Finish the project 10 days before the deadline", tasks: [])
    ]
}
