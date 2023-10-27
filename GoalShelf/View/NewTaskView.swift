//
//  NewTaskView.swift
//  GoalShelf
//
//  Created by Giuseppe Francione on 25/10/23.
//

import SwiftUI
import Combine

struct NewTaskView: View {
    var goal:Goal
    @State private var newTask:Task = Task()
    @Environment(\.dismiss) var dismiss
    let textLimit = 35
    var body: some View {
        
        VStack(spacing: 10.0){
            HStack {
                Text("Task Name").font(.caption).opacity(0.8)
                Spacer()
            }
            TextField("Visit grandma", text: $newTask.name).textFieldStyle(.roundedBorder).onReceive(Just(newTask.name)) { _ in limitText(textLimit) }
            HStack {
                Text("Task Description").font(.caption).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            TextField("She's gonna make that delicious cake!", text: $newTask.description).textFieldStyle(.roundedBorder)
            Toggle(isOn: $newTask.repeatable, label: {
                Text("Repeatable")
            })
            
            LabeledStepper("Times a week", value: $newTask.repetitionCount).opacity(newTask.repeatable ? 1.0 : 0.0).padding(.vertical)
            HStack
            {
                ForEach(WeekDaysEnum.allCases,id: \.rawValue)
                {
                    day in
                    Button(action: {
                        withAnimation(.bouncy){
                            if(newTask.notificationDays.contains(day))
                            {
                                newTask.notificationDays.remove(day)
                            }
                            else
                            {
                                newTask.notificationDays.insert(day)
                            }
                        }
                    }, label: {
                        
                        if(goal.type == .special)
                        {
                            ZStack {
                                Circle().fill(LinearGradient(colors: [.white], startPoint: .topLeading, endPoint: .bottomTrailing)).stroke(.black)
                                
                                if(newTask.notificationDays.contains(day)){
                                    Circle().stroke(lineWidth: 2.0).fill(LinearGradient(colors: [.red,.orange,.yellow,.green,.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    
                                }
                                Text(day.rawValue.prefix(3)).overlay{
                                    LinearGradient(
                                        colors: newTask.notificationDays.contains(day) ? goal.type.colors : [.black],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ).mask(
                                        Text(day.rawValue.prefix(3))
                                    )
                                }
                            }
                            
                        }
                        else
                        {
                            ZStack {
                                Circle().fill(LinearGradient(colors: newTask.notificationDays.contains(day) ? goal.type.colors: [], startPoint: .topLeading, endPoint: .bottomTrailing)).stroke(newTask.notificationDays.contains(day) ? .clear : .black)
                                
                                Text(day.rawValue.prefix(3)).foregroundStyle(newTask.notificationDays.contains(day) ? .white : .black)
                            }.shadow(color: .gray,radius: newTask.notificationDays.contains(day) ? 2 : 0)
                        }
                        
                        
                    })
                    
                }
            }.opacity(newTask.repeatable ? 1.0 : 0.0)
            
            
            LabeledStepper("How many weeks (TODO)",value: $newTask.repetitionPermanence).opacity(newTask.repeatable ? 1.0 : 0.0).padding(.vertical)
            Spacer()
            Button(action: {
                goal.tasks.append(newTask)
                dismiss()
            }, label: {
                Text("Create")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                
            }).buttonStyle(.borderedProminent)
                .clipShape(Capsule())
            .disabled(newTask.name.isEmpty || newTask.description.isEmpty || (newTask.repeatable && newTask.notificationDays.isEmpty))
            .opacity(newTask.name.isEmpty || newTask.description.isEmpty || (newTask.repeatable && newTask.notificationDays.isEmpty) ? 0.5 : 1)
            
        }.padding()
        Spacer()
    }
    
    
    
    
    func limitText(_ upper: Int) {
        if newTask.name.count > upper {
            newTask.name = String(newTask.name.prefix(upper))
        }
    }
}

#Preview {
    NewTaskView(goal: Goal(type: .special, name: "", adescription: "", tasks: []))
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
