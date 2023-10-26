//
//  GoalDetailView.swift
//  GoalShelf
//
//  Created by Giuseppe Casillo on 23/10/23.
//

import SwiftUI

struct GoalDetailView: View {
    @Environment (\.modelContext) private var context
    @State var goal: Goal
    @State var showCreateTask:Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text(goal.adescription)
            }
            
            List{
                ForEach(goal.tasks)
                {
                    task in
                    Button(action: {
                        goal.toggle(task)
                    }, label: {
                        HStack {
                            Image(systemName:  task.isCompleted ? "circle.fill":"circle").foregroundStyle(.blue)
                            Text(task.name)
                        }
                    }).foregroundStyle(.primary)
                    
                    
                }.onDelete(
                    
                    perform:
                        deleteTask
                )
            }.navigationBarTitle(goal.name, displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    showCreateTask.toggle()
                }, label: {
                    Image(systemName: "plus.circle")
                }).sheet(isPresented: $showCreateTask, content: {
                    NewTaskView(goal: goal).presentationDragIndicator(.visible)
                }))
            
        }
        
    }
    
    func deleteTask(at offsets: IndexSet) {
        goal.tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    GoalDetailView(goal: Goal(type: .health, name: "Lose weight", adescription: "Lose 5kg in 2 months in order to be ready for the fitness competition", tasks: [Task(name: "Following Dr. Ascanio's diet", description: "Follow the diet the doctor gave me, even when everybody around me is eating delicious unhealthy food!")]))
}
