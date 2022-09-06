//
//  TaskappApp.swift
//  Taskapp
//
//  Created by Benjamin on 28/06/2022.
//

import SwiftUI

@main
struct TaskappApp: App {
    @AppStorage("isDark") var isDark: Bool = false
    let pc = CoreDataManager.shared.persistentContainer
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, pc.viewContext).preferredColorScheme(isDark ? .dark : .light)

        }
    }
}
