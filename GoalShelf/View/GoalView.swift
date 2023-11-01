//
//  Goal.swift
//  firstapp
//
//  Created by Giuseppe Casillo on 22/10/23.
//

import SwiftUI
import SwiftData

struct GoalView: View {
    @Environment (\.modelContext) private var context
    
    @State private var isEditing = false
    @State private var confirmationShown = false
    @State private var goalTypeFilter: GoalEnum? = nil
    @State var selectedGoal: Goal?
    @State private var showModal = false
    @State private var showAlert = false
    @Query private var allGoals: [Goal]
    
    
    let disabled: [Color] = [.white, .gray]
    
    var body: some View {
        NavigationStack{
            
            HStack(alignment: .top){
                ForEach(GoalEnum.allCases, id: \.rawValue){
                    type in
                    ZStack{
                        RoundedRectangle(cornerRadius: 25.0).fill(.gray).fill(LinearGradient(colors: goalTypeFilter == type ? type.colors : disabled, startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                        Image(systemName: type.symbol)
                    }.onTapGesture {
                        withAnimation(.linear(duration: 0.2)){
                            if(goalTypeFilter == type){
                                goalTypeFilter = nil
                            }else{
                                goalTypeFilter = type
                            }
                        }
                    }
                }
            }.padding()
                .frame(height: 80)
                .foregroundStyle(.white)
            
            ScrollView{
                if(allGoals.filter({goalTypeFilter == nil || goalTypeFilter == $0.type}).isEmpty){
                    Spacer(minLength: UIScreen.main.bounds.size.height/4)
                    
                    VStack {
                        
                        Text("It looks like there are no goals here.").opacity(0.8)
                        Text("Add some!").opacity(0.8)
                        Spacer().frame(height: 7)
                        Button(action: {
                            showModal.toggle()
                        }, label: {
                            Image(systemName: "plus.circle").font(.title3)
                        }).disabled(isEditing)
                        .sheet(isPresented: $showModal ){
                            NewGoalView(isEditing: isEditing)
                                .presentationDetents([.height(550)])
                                .presentationCornerRadius(30)
                                .presentationDragIndicator(.visible)
                        }
                        
                        
                    }
                    
                }
                else
                {
                    ForEach(allGoals.filter({goalTypeFilter == nil || goalTypeFilter == $0.type})) //filtered list
                    {
                        goal in
                        
                        ZStack {
                            NavigationLink(destination: GoalDetailView(goal: goal), label: {
                                ZStack(alignment: .topLeading){
                                    RoundedRectangle(cornerRadius: 25.0).fill(.white).padding(.vertical,-10).shadow(radius: 5)
                                    HStack{
                                        Image(systemName: goal.type.symbol).font(.title).foregroundStyle(LinearGradient(colors: goal.type.colors, startPoint:.topLeading, endPoint:.bottomTrailing))
                                        Text(goal.name).font(.title2).foregroundStyle(.black)
                                        
                                        Spacer()
                                        Image(systemName: isEditing ? (goal.isCompleted ? "pencil.slash" : "pencil.and.scribble") : "chevron.right").foregroundStyle(.black).frame( alignment: .trailing)
                                        
                                    }.padding(.horizontal)
                                    
                                }.padding()
                            })
                            .disabled(isEditing)
                            
                            if(isEditing){
                                    Button(action:{
                                        if(goal.isCompleted == false){
                                            selectedGoal = goal
                                        }
                                        else{
                                            showAlert.toggle()
                                        }
                                    } , label: {
                                        Color.clear
                                    })
                                    .alert(isPresented: $showAlert) {
                                        Alert(title: Text("Goal not editable"), message: Text("You can't edit this goal because your already achieved it."), dismissButton: .default(Text("Ok")))
                                    }
                                
                            }
                        }
                        
                    }.sheet(item: $selectedGoal,
                            onDismiss: { if(allGoals.isEmpty){ isEditing = false} },
                            content: { goal in
                            if(isEditing){
                            NewGoalView(newGoal: goal, isEditing: isEditing)
                                    .presentationDetents([.height(550)])
                                    .presentationCornerRadius(30)
                                    .presentationDragIndicator(.visible)
                                    .interactiveDismissDisabled()
                        }
                        
                    })
                }
                
            }
            .navigationTitle("My Goals").navigationBarItems(
                leading:
                    
                    //EditButton().disabled(allGoals.isEmpty)
                
                Button(action: {
                    isEditing.toggle()
                }, label: {
                    Text(isEditing ? "Done" : "Edit")
                }).disabled(allGoals.isEmpty)
                ,
                
                trailing: Button(action: {
                    showModal.toggle()
                }, label: {
                    Image(systemName: "plus.circle")
                }).sheet(isPresented: $showModal ){
                    NewGoalView(isEditing: isEditing)
                        .presentationDetents([.height(550)])
                        .presentationCornerRadius(30)
                        .presentationDragIndicator(.visible)
                }
                .disabled(isEditing)
            )
            
        }
        
    }
       
}

#Preview {
    GoalView()
        .modelContainer(for : Goal.self)
}
