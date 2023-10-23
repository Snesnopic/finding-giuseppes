//
//  GoalDetailView.swift
//  GoalShelf
//
//  Created by Giuseppe Casillo on 23/10/23.
//

import SwiftUI

struct GoalDetailView: View {
    var goal: Goal
    var body: some View {
        NavigationStack{
       
            /*Everything inside here looks bad
             We need to do all the design. This was just a test
             */
            
            VStack{
                Text("Goal description").font(.title2)
                Text(goal.description)
            }
    
            Text("Goal-related tasks").font(.title2)
            List{
            ForEach(goal.tasks){ task in
                
                    HStack{
                        Text(task.name)
                        Image(systemName: "circle")
                    }
                }
            }.navigationTitle(goal.name)
        }
    }
}


#Preview {
    GoalDetailView(goal: Goal(type: .health, name: "Lose weight", description: "Lose 5kg in 2 months in order to be ready for the fitness competition", tasks: [Task(name: "Following Dr. Ascanio's diet", description: "Follow the diet the doctor gave me, even when everybody around me is eating delicious unhealthy food!")]))
}
