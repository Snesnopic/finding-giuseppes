//
//  GoalListView.swift
//  GoalShelf
//
//  Created by Giuseppe Francione on 19/10/23.
//

import SwiftUI

struct GoalListView: View {
    var body: some View {
        //Spacer()
        NavigationStack {
            VStack
            {
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: [.lightEducation,.strongEducation], startPoint: .topLeading, endPoint: .bottomTrailing))
                    VStack{
                        Image(systemName: "books.vertical.fill")
                        Text("Education")
                    }.foregroundStyle(.white)
                    
                    
                }.padding(.horizontal).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                
                ZStack{
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(LinearGradient(colors: [.lightWork,.strongWork], startPoint: .topLeading, endPoint: .bottomTrailing))
                    VStack{
                        Image(systemName: "bag.fill")
                        Text("Work")
                    }.foregroundStyle(.white)
                }.padding(.horizontal).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0).fill(LinearGradient(colors: [.lightHealth,.strongHealth], startPoint: .topLeading, endPoint: .bottomTrailing))
                    VStack{
                        Image(systemName: "leaf.fill")
                        Text("Health")
                    }.foregroundStyle(.white)
                }.padding(.horizontal).shadow(radius: 10)
                
                
                ZStack{
                    Color.white.clipShape(RoundedRectangle(cornerRadius: 25.0)).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    RoundedRectangle(cornerRadius: 25.0).stroke(lineWidth: 2.0).fill(LinearGradient(colors: [.red,.orange,.yellow,.green,.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    VStack
                    {
                        Image(systemName: "fireworks")
                        Text("Special")
                    }.foregroundStyle(LinearGradient(colors: [.red,.orange,.yellow,.green,.blue,.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    
                }.padding(.horizontal)
            }.font(.largeTitle).navigationTitle("Categories").padding(.vertical)
        }
    }
}

#Preview {
    GoalListView()
}
