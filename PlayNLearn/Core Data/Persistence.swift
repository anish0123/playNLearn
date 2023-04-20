//
//  Persistence.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 18.4.2023.
//

import Foundation
import CoreData

// Persistence Controller class introduced to get the data from managed object context
struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "PlayNLearn")

        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolve Error: \(error)")
            }
        }
    }
}
