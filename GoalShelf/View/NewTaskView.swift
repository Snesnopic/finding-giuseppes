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
    @State private var showRepetition:Bool = true
    @State private var selectedDays = Set<WeekDaysEnum>()
    let textLimit = 35
    var body: some View {
        
        VStack(spacing: 10.0){
            Text("Task Name").font(.caption).foregroundStyle(.gray)
            TextField("Visit grandma", text: $newTask.name).textFieldStyle(.roundedBorder).onReceive(Just(newTask.name)) { _ in limitText(textLimit) }
            Text("Task Description").font(.caption).foregroundStyle(.gray)
            TextField("She's gonna make that delicious cake!", text: $newTask.description).textFieldStyle(.roundedBorder)
            Toggle(isOn: $showRepetition, label: {
                Text("Repeatable")
            })
            
            LabeledStepper("Times a week", value: $newTask.repetitionCount).opacity(showRepetition ? 1.0 : 0.0).padding(.vertical)
            HStack
            {
                ForEach(WeekDaysEnum.allCases,id: \.rawValue)
                {
                    day in
                    Button(action: {
                        withAnimation(.bouncy){
                            if(selectedDays.contains(day))
                            {
                                selectedDays.remove(day)
                            }
                            else
                            {
                                selectedDays.insert(day)
                            }
                        }
                    }, label: {
                        
                        if(goal.type == .special)
                        {
                            ZStack {
                                Circle().fill(LinearGradient(colors: [.white], startPoint: .topLeading, endPoint: .bottomTrailing)).stroke(.black)
                                
                                if(selectedDays.contains(day)){
                                    Circle().stroke(lineWidth: 2.0).fill(LinearGradient(colors: [.red,.orange,.yellow,.green,.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    
                                }
                                Text(day.rawValue.prefix(3)).overlay{
                                    LinearGradient(
                                        colors: selectedDays.contains(day) ? goal.type.colors : [.black],
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
                                Circle().fill(LinearGradient(colors: selectedDays.contains(day) ? goal.type.colors: [], startPoint: .topLeading, endPoint: .bottomTrailing)).stroke(selectedDays.contains(day) ? .clear : .black)
                                
                                Text(day.rawValue.prefix(3)).foregroundStyle(selectedDays.contains(day) ? .white : .black)
                            }.shadow(color: .gray,radius: selectedDays.contains(day) ? 2 : 0)
                        }
                        
                        
                    })
                    
                }
            }.opacity(showRepetition ? 1.0 : 0.0)
            
            
            LabeledStepper("How many weeks (TODO)",value: $newTask.repetitionPermanence).opacity(showRepetition ? 1.0 : 0.0).padding(.vertical)
            
            Button(action: {
               
                    
            }, label: {
                Text("Create")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.blue)
                
            })
            .disabled(newTask.name.isEmpty || newTask.description.isEmpty)
            .opacity(newTask.name.isEmpty || newTask.description.isEmpty ? 0.5 : 1)
            
        }.padding()
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

enum WeekDaysEnum: String, CaseIterable
{
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}
