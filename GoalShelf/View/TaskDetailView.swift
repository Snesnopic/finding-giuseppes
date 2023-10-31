//
//  TaskDetailView.swift
//  GoalShelf
//
//  Created by Giuseppe Casillo on 31/10/23.
//

import SwiftUI

struct TaskDetailView: View {
    @State var task: Task
    var body: some View {
        
        
            
                
                VStack{
                    Text("Description").font(.title2).bold()
                    Text(task.description).lineLimit(5).multilineTextAlignment(.center)
                    
                    Spacer().frame(height: 30)
                    Text((task.repeatable ? "Recurring task on days: " : ""))
                    
                    HStack{
                        
                        if(task.notificationDays.contains(.monday)){
                            Text("MON").bold()
                        }
                        if(task.notificationDays.contains(.tuesday)){
                            Text("TUE").bold()
                        }
                        
                        if(task.notificationDays.contains(.wednesday)){
                            Text("WED").bold()
                        }
                        if(task.notificationDays.contains(.thursday)){
                            Text("THU").bold()
                        }
                        if(task.notificationDays.contains(.friday)){
                            Text("FRI").bold()
                        }
                        if(task.notificationDays.contains(.saturday)){
                            Text("SAT").bold()
                        }
                        if(task.notificationDays.contains(.sunday)){
                            Text("SUN").bold()
                        }
                        
                        

                    }
                    
            .padding()
            
                }
        
                .frame(height: task.repeatable ? 250 : 150)
            .padding(.all, 25)
        
    }
    
    enum WeekDaysEnum: String, CaseIterable, Codable
    {
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
    }
}


#Preview {
    TaskDetailView(task: Task(name: "Finish the project", description: "I need to finish this project because blablabla",isCompleted: false, repeatable: true, notificationDays: [.friday, .monday]))
}
