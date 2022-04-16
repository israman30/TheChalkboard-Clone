//
//  ChalkboardApp.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/2/22.
//

import SwiftUI

@main
struct ChalkboardApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
