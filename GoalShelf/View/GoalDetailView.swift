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
    @State private var selectedTask: Task?
    @State private var showPopOver: Bool = false
    @State private var showAlert: Bool = false
    @State var viewWidth = CGFloat.zero
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
                            Spacer(minLength: UIScreen.main.bounds.size.height/3.5)
                            HStack {
                                Spacer()
                                VStack {
                                    Text("It looks like there are no tasks here.").font(.title3).multilineTextAlignment(.center)
                                    Text("Add some!").font(.title3)
                                    Spacer().frame(height: 7)
                                    Button(action: {
                                        showCreateTask.toggle()
                                    }, label: {
                                        Image(systemName: "plus.circle").font(.title2)
                                    }).disabled(goal.isCompleted)
                                    
                                    
                                    
                                }
                                Spacer()
                            }
                        }){}
                    }
                    else{
                        ForEach(goal.tasks){
                            task in
                            
                            
                            Button(action: {
                                selectedTask = task
                                if(!task.repeatable){
                                    goal.toggle(task)
                                }
                                
                            }, label: {
                                HStack {
                                    if(task.repeatable){
                                        
                                        Text("R").foregroundStyle(.blue).font(.title3)
                                    } else{
                                        Image(systemName:  task.isCompleted ? "circle.fill":"circle").foregroundStyle(.blue)
                                    }
                                        Text(task.name)
                                }
                            }).disabled(goal.isCompleted)
                            
                            .contextMenu{
                                Text(task.name)
                            } preview:{
                                TaskDetailView(task: task)
                            }
                            
                            .foregroundStyle(.primary)
                        }
                        .onDelete(perform: deleteTask)
                        
                        
                    }
                }.navigationBarTitle(goal.name, displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        showCreateTask.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                        .disabled(goal.isCompleted)
                        .sheet(isPresented: $showCreateTask, content: {
                        NewTaskView(goal: goal).presentationDetents([.height(500)])
                            .presentationCornerRadius(30)
                            .presentationDragIndicator(.visible)
                    }))
                VStack {
                    Spacer(minLength: UIScreen.main.bounds.size.height/4)
                    HStack {
                        Spacer()
                        
                            
                        ZStack {
                            
                            if(goal.isCompleted){
                                Text("This goal has already been achieved!")
                            }
                            
                            Button(action: {
                                showAlert.toggle()
                                goal.isCompleted = true
                            }, label: {
                                Text("Complete goal")
                            })
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Congratulations!"), message: Text("You finally achieved your goal. Keep it up!"), dismissButton: .default(Text("Got it!")))
                            }
                            .disabled(goal.isCompleted)
                            .opacity((goal.isCompleted ? 0 : 1))
                            .clipShape(Capsule()).padding().buttonStyle(.borderedProminent).disabled(goal.tasks.isEmpty || !goal.tasks.allSatisfy({ task in
                                task.isCompleted
                            }))
                            
                            
                            
                        }
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
    GoalDetailView(goal: Goal(type: .health, name: "Lose weight", adescription: "Lose 5kg in 2 months in order to be ready for the fitness competition" , isCompleted: false, tasks: [Task(name: "hello", description: "òawdhskòdshòiahflkhawdlkfhlaishfvliashgljagclihawòoifhyiua", repeatable: true, notificationDays: [.monday, .tuesday, .saturday])]))
}
