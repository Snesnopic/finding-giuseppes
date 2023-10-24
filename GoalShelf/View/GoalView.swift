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
    var viewModel = GoalViewModel()
    
    var body: some View {
        NavigationStack{
            
            ScrollView{
                ForEach(viewModel.goals){
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
