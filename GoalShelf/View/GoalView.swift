//
//  Goal.swift
//  firstapp
//
//  Created by Giuseppe Casillo on 22/10/23.
//

import SwiftUI
import SwiftData

struct GoalView: View {
    @State var showModal = false
    @State private var goalType: GoalEnum = .none
    @Query private var goals: [Goal]

    
    let disabled: [Color] = [.white, .gray]
    
    var body: some View {
        
        let filteredGoals = goals.filter(filtering)
        NavigationStack{
        
        HStack(alignment: .top){
            ZStack{
                RoundedRectangle(cornerRadius: 25.0).fill(.gray).fill(LinearGradient(colors: goalType == .education ? GoalEnum.education.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Image(systemName: GoalEnum.education.symbol)
            }.onTapGesture {
                withAnimation(.linear(duration: 0.2)){
                    if(goalType == .education){
                        goalType = .none
                    }else{
                        goalType = .education
                    }
                }
            }
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalType == .work ? GoalEnum.work.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Image(systemName: GoalEnum.work.symbol)
            }.onTapGesture {
                withAnimation(.linear(duration: 0.2)){
                    if(goalType == .work){
                        goalType = .none
                    }else{
                        goalType = .work
                    }
                }
            }
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalType == .health ? GoalEnum.health.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Image(systemName: GoalEnum.health.symbol)
            }.onTapGesture {
                withAnimation(.linear(duration: 0.2)){
                    if(goalType == .health){
                        goalType = .none
                    }else{
                        goalType = .health
                    }
                }
            }
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalType == .special ? GoalEnum.special.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                Image(systemName: GoalEnum.special.symbol)
            }.onTapGesture {
                withAnimation(.linear(duration: 0.2)){
                    if(goalType == .special){
                        goalType = .none
                    }else{
                        goalType = .special
                    }
                }
            }
            
            
        }.padding()
            .frame(height: 80)
            .foregroundStyle(.white)
        
            ScrollView{
                ForEach(filteredGoals){
                    goal in
                    
                    NavigationLink(destination: GoalDetailView(goal: goal), label: {
                        
                        ZStack(alignment: .topLeading){
                            
                            RoundedRectangle(cornerRadius: 25.0).fill(.white).padding(.vertical,-10).shadow(radius: 5)
                            
                            HStack{
                                Image(systemName: goal.type.symbol).font(.title).foregroundStyle(LinearGradient(colors: goal.type.colors, startPoint:.topLeading, endPoint:.bottomTrailing))
                                Text(goal.name).font(.title2).foregroundStyle(.black)
                                
                                Spacer()
                                Image(systemName: "chevron.right").foregroundStyle(.black).frame( alignment: .trailing)
                                
                            }.padding(.horizontal)
                            
                            
                            
                        }.padding()
                    })
                }
            }
            .navigationTitle("My Goals").toolbar{
                Button(action: {
                    showModal = true
                    
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }
            .sheet(isPresented: $showModal){
                NewGoalView().presentationDetents([.height(700)])
                    .presentationCornerRadius(30)
                    .presentationDragIndicator(.visible)
            }
            
            
        }
    }
    
    func filtering(goal: Goal) -> Bool {
        if(goalType == .education){
            return goal.type == .education
        }else if(goalType == .work){
            return goal.type == .work
        }else if(goalType == .health){
            return goal.type == .health
        }else if(goalType == .special){
            return goal.type == .special
        }
        else {
            return true
        }
      }
      
}

#Preview {
    GoalView()
        .modelContainer(for : Goal.self)
}
