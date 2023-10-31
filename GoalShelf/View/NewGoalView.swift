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
    
    @State public var newGoal: Goal = Goal(type: .education, name: "", adescription: "", isCompleted: false, tasks: [])
    @State private var confirmationShown = false
    
    var isEditing:Bool = false
    let textLimit = 35
    let disabled: [Color] = [.white, .gray]
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 9){
                Text("Goal Name").font(.caption).opacity(0.8)
                TextField("Finish the school project", text: $newGoal.name).textFieldStyle(.roundedBorder).onReceive(Just(newGoal.name)) { _ in limitText(textLimit) }
                Text("Goal Description").font(.caption).opacity(0.8)
                TextField("We're so behind...", text: $newGoal.adescription, axis: .vertical)
                    .lineLimit(5, reservesSpace: true)
                    .textFieldStyle(.roundedBorder)
                
                
            }.padding()
            
            
            
            HStack{
                
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: newGoal.type == .education ? GoalEnum.education.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                    VStack{
                        Image(systemName: GoalEnum.education.symbol)
                        Text(GoalEnum.education.rawValue)
                    }.foregroundStyle(.white)
                }.shadow(radius: 5).onTapGesture {
                    withAnimation(.linear(duration: 0.5)){
                        newGoal.type = .education
                        
                    }
                }
                Spacer().frame(width: 15)
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: newGoal.type == .work ? GoalEnum.work.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                    VStack{
                        Image(systemName: GoalEnum.work.symbol)
                        Text(GoalEnum.work.rawValue)
                    }.foregroundStyle(.white)
                }.shadow(radius: 5).onTapGesture {
                    withAnimation(.linear(duration: 0.5)){
                        newGoal.type = .work
                    }
                }
            }
            
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: newGoal.type == .health ? GoalEnum.health.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                    VStack{
                        Image(systemName: GoalEnum.health.symbol)
                        Text(GoalEnum.health.rawValue)
                    }.foregroundStyle(.white)
                }.shadow(radius: 5).onTapGesture {
                    withAnimation(.linear(duration: 0.5)){
                        newGoal.type = .health
                    }
                }
                Spacer().frame(width: 15)
                ZStack{
                    Color.white.clipShape(RoundedRectangle(cornerRadius: 25.0)).shadow(radius: 5).frame(width: 180, height: 100)
                    RoundedRectangle(cornerRadius: 25.0).stroke(lineWidth: 2.0).fill(LinearGradient(colors: newGoal.type == .special ? GoalEnum.special.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                    VStack
                    {
                        Image(systemName: GoalEnum.special.symbol)
                        Text(GoalEnum.special.rawValue)
                    }.foregroundStyle(LinearGradient(colors: newGoal.type == .special ? GoalEnum.special.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                }.onTapGesture {
                    withAnimation(.linear(duration: 0.5)){
                        newGoal.type = .special
                    }                    
                }
                
            }
            
            Spacer()
            VStack {
                Button(action: {
                    addGoal()
                    dismiss()
                    
                }, label: {
                    Text(isEditing ? "Save" : "Create")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                    
                    
                }).buttonStyle(.borderedProminent)
                    .clipShape(Capsule())
                    .disabled(newGoal.name.isEmpty || newGoal.adescription.isEmpty)
                    .opacity(newGoal.name.isEmpty || newGoal.adescription.isEmpty ? 0.5 : 1)
                
                Button(role: .destructive,action: {
                    confirmationShown = true
                }, label: {
                    Text("Delete")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                    
                    
                }).confirmationDialog(
                    "Do you want to delete this element?",
                    isPresented: $confirmationShown
                ) {
                    Button(role: .destructive, action: {
                        withAnimation {
                            deleteGoal(newGoal)
                            dismiss()
                        }
                    }, label:{
                        Text("Delete")
                    })
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
                .disabled(!isEditing)
                .opacity(!isEditing ? 0 : 1)
            }
            Spacer()
        }
    }
    
    func deleteGoal(_ goal: Goal){
        context.delete(goal)
    }
    
    func limitText(_ upper: Int) {
        if newGoal.name.count > upper {
            newGoal.name = String(newGoal.name.prefix(upper))
        }
    }
    
    func addGoal(){
        context.insert(newGoal)
    }
}



#Preview {
    NewGoalView(newGoal: Goal(type: .education, name: "", adescription: "", isCompleted: false, tasks: []), isEditing: true)
}
