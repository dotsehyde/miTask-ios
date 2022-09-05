//
//  ContentView.swift
//  MiTask
//
//  Created by Benjamin on 05/09/2022.
//

import SwiftUI

enum Priority: String, CaseIterable, Identifiable {
    var id: UUID {
        return UUID()
    }
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

struct ContentView: View {
    @State private var title: String = ""
    @State private var selected: Priority = .medium
    @Environment(\.managedObjectContext) var viewContext

    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "isFavourite", ascending: false)]) private var allTasks: FetchedResults<Task>
    private func saveTask() {
        do {
            let task = Task(context: viewContext)
            task.title = title
            task.priority = selected.rawValue
            task.dateCreated = Date()
            try viewContext.save()
            title = ""
        } catch {
            print(error.localizedDescription)
        }
    }
    func priorityColor(_ p: String) -> Color {
        switch p {
        case Priority.high.rawValue:
            return Color.red
        case Priority.medium.rawValue:
            return Color.yellow
        default:
            return Color.green
        }
    }
    func updateTask(_ task: Task) {
        do {
            task.isFavourite = !task.isFavourite
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    func deleteTask(_ offsets: IndexSet) {
        offsets.forEach { i in
            let task = allTasks[i]
            viewContext.delete(task)
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                Picker("Priority", selection: $selected) {
                    ForEach(Priority.allCases) { p in
                        Text(p.rawValue).tag(p)
                    }
                } .pickerStyle(.segmented)
                Button("Save") {
                    withAnimation {
                        saveTask()
                    }
                }.padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                List {
                    ForEach(allTasks) { task in
                        HStack {
                            Circle()
                                .fill(priorityColor(task.priority!))
                                .frame(width: 15, height: 15)
                            Spacer().frame(width: 20)
                            Text(task.title ?? "")
                            Spacer()
                            Image(systemName: task.isFavourite ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .onTapGesture {
                                updateTask(task)
                            }
                        }
                    }.onDelete { i in
                        deleteTask(i)
                    }
                }

                    .background(Color.white)
                Spacer()
            }
                .padding()
                .navigationBarTitle("MiTask")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let pc = CoreDataManager.shared.persistentContainer
        ContentView().environment(\.managedObjectContext, pc.viewContext)
    }
}
