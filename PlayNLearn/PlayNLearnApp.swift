//
//  PlayNLearnApp.swift
//  PlayNLearn
//
//  Created by Ritesh Ghimire on 3.4.2023.
//

import SwiftUI

@main
struct PlayNLearnApp: App {
    let persistenceContainer = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
