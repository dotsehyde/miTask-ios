//
//  MiTaskApp.swift
//  MiTask
//
//  Created by Benjamin on 05/09/2022.
//

import SwiftUI

@main
struct MiTaskApp: App {

    let pc = CoreDataManager.shared.persistentContainer
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, pc.viewContext)
        }
    }
}
