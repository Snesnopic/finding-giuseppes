//
//  NewGoalView.swift
//
//
//  Created by Giuseppe Casillo on 21/10/23.
//

import SwiftUI
import Combine

struct NewGoalView: View {
    
    @Environment (\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let textLimit = 22
    let disabled: [Color] = [.white, .gray]
    
    @State private var goalName: String = ""
    @State private var goalType: GoalEnum = .education
    @State private var goalDescription: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 9){
            Text("Goal Name").font(.caption).foregroundStyle(.gray)
            TextField("Lose weight", text: $goalName).textFieldStyle(.roundedBorder).onReceive(Just(goalName)) { _ in limitText(textLimit) }
            Text("Goal Description").font(.caption).foregroundStyle(.gray)
            TextField("Losing 5 kg in 2 months!", text: $goalDescription).textFieldStyle(.roundedBorder)
            
        }.padding()
        
        Spacer().frame(height: 10)
        
        HStack{
            
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalType == .education ? colorMap[.education]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack{
                    Image(systemName: symbolMap[.education]!)
                    Text(GoalEnum.education.rawValue)
                }.foregroundStyle(.white)
            }.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    goalType = .education
                    
                }
            }
            Spacer().frame(width: 15)
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalType == .work ? colorMap[.work]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack{
                    Image(systemName: symbolMap[.work]!)
                    Text(GoalEnum.work.rawValue)
                }.foregroundStyle(.white)
            }.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    goalType = .work
                }
            }
        }
        
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalType == .health ? colorMap[.health]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack{
                    Image(systemName: symbolMap[.health]!)
                    Text(GoalEnum.health.rawValue)
                }.foregroundStyle(.white)
            }.shadow(radius: 10).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    goalType = .health
                }
            }
            Spacer().frame(width: 15)
            ZStack{
                Color.white.clipShape(RoundedRectangle(cornerRadius: 25.0)).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).frame(width: 180, height: 100)
                RoundedRectangle(cornerRadius: 25.0).stroke(lineWidth: 2.0).fill(LinearGradient(colors: goalType == .special ? colorMap[.special]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack
                {
                    Image(systemName: symbolMap[.special]!)
                    Text(GoalEnum.special.rawValue)
                }.foregroundStyle(LinearGradient(colors: goalType == .special ? colorMap[.special]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                
            }.onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    goalType = .special
                }
            }
            
        }
        
        Button(action: {
            let newGoal = Goal(type: goalType, name: goalName, description: goalDescription, tasks: [])
            
            do {
                try managedObjectContext.save()
            } catch {
                
            }
        }, label: {
            Text("Create")
                .font(.title3)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.blue)
            
        })
        .disabled(goalName.isEmpty || goalDescription.isEmpty)
        .opacity(goalName.isEmpty || goalDescription.isEmpty ? 0.5 : 1)
    }
    
    
    
    
    func limitText(_ upper: Int) {
            if goalName.count > upper {
                goalName = String(goalName.prefix(upper))
            }
        }
}



#Preview {
    NewGoalView()
}
