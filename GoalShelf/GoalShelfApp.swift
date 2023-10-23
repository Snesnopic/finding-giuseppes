//
//  GoalShelfApp.swift
//  GoalShelf
//
//  Created by Giuseppe Francione on 19/10/23.
//

import SwiftUI

@main
struct GoalShelfApp: App {
    var body: some Scene {
        WindowGroup {
            TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                GoalView().tabItem {
                    VStack
                    {
                        Image(systemName: "fireworks")
                        Text("Learners")
                    } }.tag(1)
                GoalListView().tabItem {
                    VStack{
                        Image(systemName: "person.3.fill")
                        Text("Teams")
                    }
                     }.tag(2)
            }
            
        }
    }
}
