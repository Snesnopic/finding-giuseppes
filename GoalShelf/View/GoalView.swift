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
    @State private var goalTypeFilter: GoalEnum? = nil
    @Query private var allGoals: [Goal]
    
    
    let disabled: [Color] = [.white, .gray]
    
    var body: some View {
        NavigationStack{
            
            HStack(alignment: .top){
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0).fill(.gray).fill(LinearGradient(colors: goalTypeFilter == .education ? GoalEnum.education.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                    Image(systemName: GoalEnum.education.symbol)
                }.onTapGesture {
                    withAnimation(.linear(duration: 0.2)){
                        if(goalTypeFilter == .education){
                            goalTypeFilter = nil
                        }else{
                            goalTypeFilter = .education
                        }
                    }
                }
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalTypeFilter == .work ? GoalEnum.work.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                    Image(systemName: GoalEnum.work.symbol)
                }.onTapGesture {
                    withAnimation(.linear(duration: 0.2)){
                        if(goalTypeFilter == .work){
                            goalTypeFilter = nil
                        }else{
                            goalTypeFilter = .work
                        }
                    }
                }
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalTypeFilter == .health ? GoalEnum.health.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                    Image(systemName: GoalEnum.health.symbol)
                }.onTapGesture {
                    withAnimation(.linear(duration: 0.2)){
                        if(goalTypeFilter == .health){
                            goalTypeFilter = nil
                        }else{
                            goalTypeFilter = .health
                        }
                    }
                }
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: goalTypeFilter == .special ? GoalEnum.special.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                    Image(systemName: GoalEnum.special.symbol)
                }.onTapGesture {
                    withAnimation(.linear(duration: 0.2)){
                        if(goalTypeFilter == .special){
                            goalTypeFilter = nil
                        }else{
                            goalTypeFilter = .special
                        }
                    }
                }
                
                
            }.padding()
                .frame(height: 80)
                .foregroundStyle(.white)
            
            ScrollView{
                ForEach(allGoals.filter({goalTypeFilter == nil || goalTypeFilter == $0.type})) //filtered list
                {
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
}

#Preview {
    GoalView()
        .modelContainer(for : Goal.self)
}
