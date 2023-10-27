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
            ZStack {
                List{
                    if(goal.tasks.isEmpty){
                        Section(footer:
                                    VStack {
                            Spacer(minLength: UIScreen.main.bounds.size.height/3)
                            HStack {
                                Spacer()
                                Text("Looks like you have no tasks. Add some!").opacity(0.8)
                                Spacer()
                            }
                        }){}
                    }
                    else{
                        ForEach(goal.tasks){
                            task in
                            Button(action: {
                                goal.toggle(task)
                            }, label: {
                                HStack {
                                    Image(systemName:  task.isCompleted ? "circle.fill":"circle").foregroundStyle(.blue)
                                    Text(task.name)
                                }
                            }).foregroundStyle(.primary)
                        }.onDelete(perform: deleteTask)
                    }
                }.navigationBarTitle(goal.name, displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        showCreateTask.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    }).sheet(isPresented: $showCreateTask, content: {
                        NewTaskView(goal: goal).presentationDetents([.height(500)])
                            .presentationCornerRadius(30)
                            .presentationDragIndicator(.visible)
                    }))
                VStack {
                    Spacer(minLength: UIScreen.main.bounds.size.height/4)
                    HStack {
                        Spacer()
                        Button(action: {}, label: {
                            Text("Complete goal")
                        }).clipShape(Capsule()).padding().buttonStyle(.borderedProminent).disabled(goal.tasks.isEmpty || !goal.tasks.allSatisfy({ task in
                            task.isCompleted
                        }))
                        Spacer()
                    }
                }.opacity(goal.tasks.isEmpty || !goal.tasks.allSatisfy({ task in
                    task.isCompleted
                }) ? 0 : 1)
            }
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        goal.tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    GoalDetailView(goal: Goal(type: .health, name: "Lose weight", adescription: "Lose 5kg in 2 months in order to be ready for the fitness competition", tasks: []))
}
