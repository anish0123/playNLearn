//
//  Persistence.swift
//  PlayNLearn
//
//  Created by Anish Maharjan on 18.4.2023.
//

import Foundation
import CoreData

// Persistence Controller class introduced to get the data from managed object context
// source: https://www.hackingwithswift.com/books/ios-swiftui/how-to-combine-core-data-and-swiftui
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
