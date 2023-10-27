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
    @Environment (\.modelContext) private var context
    @Environment (\.dismiss) private var dismiss
    
    
    
    let textLimit = 35
    let disabled: [Color] = [.white, .gray]
    
    @State private var goalName: String = ""
    @State private var goalType: GoalEnum = .education
    @State private var goalDescription: String = ""
    var body: some View {
        Spacer().frame(height: 20)
        VStack(alignment: .leading, spacing: 9){
            Text("Goal Name").font(.caption).foregroundStyle(.gray)
            TextField("Finish the school project", text: $goalName).textFieldStyle(.roundedBorder).onReceive(Just(goalName)) { _ in limitText(textLimit) }
            Text("Goal Description").font(.caption).foregroundStyle(.gray)
            TextField("We're so behind...", text: $goalDescription).textFieldStyle(.roundedBorder)
            
        }.padding()
        
        Spacer().frame(height: 10)
        
        HStack{
            
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalType == .education ? GoalEnum.education.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack{
                    Image(systemName: GoalEnum.education.symbol)
                    Text(GoalEnum.education.rawValue)
                }.foregroundStyle(.white)
            }.shadow(radius: 5).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    goalType = .education
                    
                }
            }
            Spacer().frame(width: 15)
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalType == .work ? GoalEnum.work.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack{
                    Image(systemName: GoalEnum.work.symbol)
                    Text(GoalEnum.work.rawValue)
                }.foregroundStyle(.white)
            }.shadow(radius: 5).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    goalType = .work
                }
            }
        }
        
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalType == .health ? GoalEnum.health.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack{
                    Image(systemName: GoalEnum.health.symbol)
                    Text(GoalEnum.health.rawValue)
                }.foregroundStyle(.white)
            }.shadow(radius: 5).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    goalType = .health
                }
            }
            Spacer().frame(width: 15)
            ZStack{
                Color.white.clipShape(RoundedRectangle(cornerRadius: 25.0)).shadow(radius: 5).frame(width: 180, height: 100)
                RoundedRectangle(cornerRadius: 25.0).stroke(lineWidth: 2.0).fill(LinearGradient(colors: goalType == .special ? GoalEnum.special.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack
                {
                    Image(systemName: GoalEnum.special.symbol)
                    Text(GoalEnum.special.rawValue)
                }.foregroundStyle(LinearGradient(colors: goalType == .special ? GoalEnum.special.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                
            }.onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    goalType = .special
                }
            }
            
        }
        
        Spacer()
        Button(action: {
            addGoal()
            dismiss()
            
        }, label: {
            Text("Create")
                .font(.title3)
                .fontWeight(.semibold)
                .textScale(.secondary)
            
            
        }).buttonStyle(.borderedProminent)
            .clipShape(Capsule())
            .disabled(goalName.isEmpty || goalDescription.isEmpty)
            .opacity(goalName.isEmpty || goalDescription.isEmpty ? 0.5 : 1)
        Spacer()
    }
    
    
    
    
    func limitText(_ upper: Int) {
        if goalName.count > upper {
            goalName = String(goalName.prefix(upper))
        }
    }
    
    func addGoal(){
        let newGoal = Goal(type: goalType, name: goalName, adescription: goalDescription, tasks: [])
        
        context.insert(newGoal)
    }
}



#Preview {
    NewGoalView()
}
