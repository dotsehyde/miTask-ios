//
//  CoreData.swift
//  MiTask
//
//  Created by Benjamin on 05/09/2022.
//

import Foundation
import CoreData

struct CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()


    private init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { _, err in
            if err != nil {
                fatalError("Unable to initialize core data")
            }
        }
    }
}
