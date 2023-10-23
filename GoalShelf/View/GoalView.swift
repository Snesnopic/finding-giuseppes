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
                          
                        NavigationLink(destination: GoalDetailView(goal: goal), label: {
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 25.0).fill(.white).padding(.vertical, -10).shadow(radius: 5)
                                
                                Image(systemName: "chevron.right").foregroundStyle(.black).frame(width: 330, alignment: .trailing)
                                
                                HStack{
                                    Image(systemName: symbolMap[goal.type]!).font(.title).foregroundStyle(LinearGradient(colors: colorMap[goal.type]!, startPoint:.topLeading, endPoint:.bottomTrailing))
                                    Text(goal.name).font(.title2).foregroundStyle(.black)
                                }.padding(.horizontal, -170)
                            }
                        })
                        
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
                    .presentationDragIndicator(.visible)
            }
            

        }
    }
}

#Preview {
    GoalView()
}
