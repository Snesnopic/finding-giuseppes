//
//  GoalDetailView.swift
//  GoalShelf
//
//  Created by Giuseppe Casillo on 23/10/23.
//

import SwiftUI

struct GoalDetailView: View {
    @State var goal: Goal
    @State var showCreateTask:Bool = false
    var body: some View {
        NavigationStack{
            VStack{
                Text(goal.adescription)
            }
            
            List{
                if(goal.tasks.isEmpty)
                {
                    Section(footer:
                                VStack {
                        Spacer(minLength: UIScreen.main.bounds.size.height/3)
                        HStack {
                            Spacer()
                            Text("Looks like you have no goals. Add some!").opacity(0.8)
                            Spacer()
                        }
                    }
                    )
                    {
                        //empty
                    }
                }
                else
                {
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
                        
                        
                    }
                }
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
    
}

#Preview {
    GoalDetailView(goal: Goal(type: .health, name: "Lose weight", adescription: "Lose 5kg in 2 months in order to be ready for the fitness competition", tasks: []))
}
