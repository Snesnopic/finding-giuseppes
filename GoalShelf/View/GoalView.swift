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
                               
                        RoundedRectangle(cornerRadius: 25.0).fill(.white
                        ).shadow(radius: 8)
                        HStack{
                            
                            
                            Image(systemName: symbolMap[goal.type]!)
                                .font(.title)
                                .foregroundStyle(LinearGradient(colors: colorMap[goal.type]!, startPoint:.topLeading, endPoint:.bottomTrailing))
                                            
                            Text(goal.name).font(.title2)
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
