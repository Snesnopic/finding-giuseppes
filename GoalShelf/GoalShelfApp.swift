//
//  GoalShelfApp.swift
//  GoalShelf
//
//  Created by Giuseppe Francione on 19/10/23.
//

import SwiftUI
import SwiftData

@main
struct GoalShelfApp: App {
    
    
    //inizializzare il container PRIMA dell'avvio dell'app
     let modelContainer: ModelContainer
    
     init(){
        do{
            modelContainer = try ModelContainer(for: Goal.self)
        } catch{
            fatalError()
        }
        
    }
    
    
    
     
    var body: some Scene {
        WindowGroup {
            TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
                GoalView().tabItem {
                    VStack
                    {
                        Image(systemName: "flag.fill")
                        Text("Goals")
                    } }.tag(1)
                GoalListView().tabItem {
                    VStack{
                        Image(systemName: "person.3.fill")
                        Text("Teams")
                    }
                     }.tag(2)
            }
            
        }
        .modelContainer(modelContainer)
        
    }
}
