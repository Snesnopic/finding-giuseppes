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
            GoalView()
        }
        .modelContainer(modelContainer)
        
    }
}
