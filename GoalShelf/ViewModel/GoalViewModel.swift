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
        Goal(type: .health, name: "Lose weight", adescription: "Lose 5kg in 2 months", tasks: []),
        Goal(type: .work, name: "Finish the app", adescription: "Finish the project 10 days before the deadline", tasks: [Task(name:"Create the newTask ModalView", description: "Create a view an user can open to create a new task"), Task(name:"Create a logo", description: "Create a nice logo for the app!")])
    ]
}
