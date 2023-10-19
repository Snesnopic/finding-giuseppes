//
//  GoalListView.swift
//  GoalShelf
//
//  Created by Giuseppe Francione on 19/10/23.
//

import SwiftUI

struct GoalListView: View {
    var body: some View {
       
        NavigationStack {
            Spacer()
            VStack
                {
                    ZStack{
                        
                        List()
                        {
                            Text("Task").swipeActions {
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                                })
                            }
                        }.background(.red.opacity(0.6))
                            .scrollContentBackground(.hidden)
                        
                    }
                    ZStack{
                        Color.blue
                        List()
                        {
                            Text("Task").swipeActions {
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                                })
                            }
                        }.background(.blue.opacity(0.6))
                            .scrollContentBackground(.hidden)
                    }
                    ZStack{
                        
                        List()
                        {
                            Text("Task").swipeActions {
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                                })
                            }
                        }.background(.green.opacity(0.6))
                            .scrollContentBackground(.hidden)
                    }
                    ZStack{
                        
                        List()
                        {
                            Text("Task").swipeActions {
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                                })
                            }
                        }.background(.yellow.opacity(0.6))
                            .scrollContentBackground(.hidden)
                    }
            }.navigationTitle("Goals")
        }
    }
}

#Preview {
    GoalListView()
}
