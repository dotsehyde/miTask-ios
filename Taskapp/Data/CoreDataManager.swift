//
//  CoreDataManager.swift
//  Taskapp
//
//  Created by Benjamin on 05/09/2022.
//

import Foundation
import CoreData

struct CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()

    private init(isMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        if(isMemory) {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, err in
            if err != nil {
                fatalError("Unable to Load")
            }
        }
    }

    static var preview: CoreDataManager = {
        let result = CoreDataManager(isMemory: true)
        let viewContext = result.persistentContainer.viewContext
        for index in 1..<10 {
            let item = Item(context: viewContext)
            item.completion = false
            item.id = UUID()
            item.dateCreated = Date()
            item.task = "Task \(index)"
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        return result
    }()
}
