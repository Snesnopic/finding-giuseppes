//
//  Goal.swift
//  firstapp
//
//  Created by Giuseppe Casillo on 22/10/23.
//

import SwiftUI

struct GoalView: View {
    @State var showModal = false
    var viewModel = GoalViewModel()
    
    var body: some View {
        NavigationStack{
            
            ScrollView{
                ForEach(viewModel.goals){
                    goal in
                    ZStack{
                               
                        RoundedRectangle(cornerRadius: 25.0).size(CGSize(width: 360.0, height: 100.0)).fill(.white
                        ).shadow(radius: 8)
                        HStack{
                            
                            if(goal.type == "Health"){
                                Image(systemName: "leaf").font(.largeTitle).foregroundStyle(LinearGradient(colors: [.lightHealth, .strongHealth], startPoint: .topLeading, endPoint: .bottomTrailing))
                            }
                            if(goal.type == "Work"){
                                Image(systemName: "bag").font(.largeTitle).foregroundStyle(LinearGradient(colors: [.lightWork, .strongWork], startPoint: .topLeading, endPoint: .bottomTrailing))
                            }
                            if(goal.type == "Education"){
                                Image(systemName: "books.vertical").font(.largeTitle).foregroundStyle(LinearGradient(colors: [.lightEducation, .strongEducation], startPoint: .topLeading, endPoint: .bottomTrailing))
                            }
                            if(goal.type == "Special"){
                                Image(systemName: "fireworks").font(.largeTitle).foregroundStyle(LinearGradient(colors: [.red,.orange,.yellow,.green,.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            }
                            
                            Text(goal.name).font(.title)
                            Spacer()
                        }.padding()
                        
                        
                    }.padding()
                
                }.navigationTitle("My Goals").toolbar{
                    Button(action: {
                        showModal = true
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
               
                
            }.sheet(isPresented: $showModal){
                NewGoalView().presentationDetents([.height(700)])
                    .presentationCornerRadius(30)
            }
            

        }
    }
}

#Preview {
    GoalView()
}
