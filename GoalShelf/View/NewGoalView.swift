//
//  NewGoalView.swift
//
//
//  Created by Giuseppe Casillo on 21/10/23.
//

import SwiftUI

struct NewGoalView: View {
    
    @Environment (\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var eduSelected: Bool = true
    @State var workSelected: Bool = false
    @State var healthSelected: Bool = false
    @State var specialSelected: Bool = false
    var disabled: [Color] = [.white, .gray]
    
    @State private var goalName: String = ""
    @State private var goalType: GoalEnum = .education
    @State private var goalDescription: String = ""
    var body: some View {
        
        
        /*Idk why but this button down below isn't working.
         Probably the spacers fucked it up
         -Giuseppe C
         */
        
        /*
         VStack(){
         Button(action: {
         presentation.wrappedValue.dismiss()
         }, label: {
         Image(systemName: "xmark.circle.fill")
         .font(.title)
         .tint(.red).padding(.horizontal, -180)
         })
         }
         */
        
        VStack(alignment: .leading, spacing: 9){
            Text("Goal Name").font(.caption).foregroundStyle(.gray)
            TextField("Lose weight", text: $goalName).textFieldStyle(.roundedBorder)
            Text("Goal Description").font(.caption).foregroundStyle(.gray)
            TextField("Losing 5 kg in 2 months!", text: $goalDescription).textFieldStyle(.roundedBorder)
            
        }.padding()
        
        Spacer().frame(height: 10)
        
        HStack{
            
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: eduSelected ? colorMap[.education]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack{
                    Image(systemName: symbolMap[.education]!)
                    Text(GoalEnum.education.rawValue)
                }.foregroundStyle(.white)
            }.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    if(eduSelected == false){
                        eduSelected.toggle()
                        goalType = .education
                        workSelected = false
                        healthSelected = false
                        specialSelected = false
                    }
                }
            }
            Spacer().frame(width: 15)
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: workSelected ? colorMap[.work]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack{
                    Image(systemName: symbolMap[.work]!)
                    Text(GoalEnum.work.rawValue)
                }.foregroundStyle(.white)
            }.shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    if(workSelected == false){
                        workSelected.toggle()
                        goalType = .health
                        eduSelected = false
                        healthSelected = false
                        specialSelected = false
                    }
                }
            }
        }
        
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: healthSelected ? colorMap[.health]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack{
                    Image(systemName: symbolMap[.health]!)
                    Text(GoalEnum.health.rawValue)
                }.foregroundStyle(.white)
            }.shadow(radius: 10).onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    if(healthSelected == false){
                        healthSelected.toggle()
                        goalType = .health
                        eduSelected = false
                        workSelected = false
                        specialSelected = false
                    }
                }
            }
            Spacer().frame(width: 15)
            ZStack{
                Color.white.clipShape(RoundedRectangle(cornerRadius: 25.0)).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).frame(width: 180, height: 100)
                RoundedRectangle(cornerRadius: 25.0).stroke(lineWidth: 2.0).fill(LinearGradient(colors: specialSelected ? colorMap[.special]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 180, height: 100)
                VStack
                {
                    Image(systemName: symbolMap[.special]!)
                    Text(GoalEnum.special.rawValue)
                }.foregroundStyle(LinearGradient(colors: specialSelected ? colorMap[.special]! : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                
            }.onTapGesture {
                withAnimation(.linear(duration: 0.5)){
                    if(specialSelected == false){
                        specialSelected.toggle()
                        goalType = .special
                        eduSelected = false
                        healthSelected = false
                        workSelected = false
                    }
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
    
}



#Preview {
    NewGoalView()
}
