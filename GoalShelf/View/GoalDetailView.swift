//
//  GoalDetailView.swift
//  GoalShelf
//
//  Created by Giuseppe Casillo on 23/10/23.
//

import SwiftUI

struct GoalDetailView: View {
    @State var goal: Goal
    var body: some View {
        NavigationStack{
            VStack{
                Text(goal.description)
            }
            
            List{
                ForEach(goal.tasks)
                {
                    task in
                        Button(action: {
                            goal.toggle(task)
                        }, label: {
                            HStack {
                                Image(systemName:  task.isCompleted ? "circle.fill":"circle")
                                Text(task.name)
                            }
                        })
                        
                        
                }
            }.navigationBarTitle(goal.name, displayMode: .inline)
        }
        
    }

}

#Preview {
    GoalDetailView(goal: Goal(type: .health, name: "Lose weight", description: "Lose 5kg in 2 months in order to be ready for the fitness competition", tasks: [Task(name: "Following Dr. Ascanio's diet", description: "Follow the diet the doctor gave me, even when everybody around me is eating delicious unhealthy food!")]))
}
