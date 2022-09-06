//
//  ItemView.swift
//  Taskapp
//
//  Created by Benjamin on 06/09/2022.
//

import SwiftUI

struct ItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .foregroundColor(item.completion ? .pink : .primary)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)

        }
            .toggleStyle(CheckboxStyle())
            
            .onReceive(item.objectWillChange) { _ in
            if viewContext.hasChanges {
                do {

                    try viewContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}

