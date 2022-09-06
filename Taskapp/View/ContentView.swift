//
//  ContentView.swift
//  Taskapp
//
//  Created by Benjamin on 28/06/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - Properties
    @AppStorage("isDark") var isDark: Bool = false
    @State var showNewEntry: Bool = false
    @FocusState private var focusNode
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var items: FetchedResults<Item>


    private func deleteItem(_ offsets: IndexSet) {
        offsets.forEach { index in
            do {
                let item = items[index]
                viewContext.delete(item)
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: - MainView
                VStack {
                    //MARK: - Header
                    HStack(spacing: 10) {
                        //MARK: - Title
                        Text("MiTask")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        Spacer()
                        #if os(iOS)
                            EditButton()
                                .font(.system(size: 16, weight: .semibold, design: .rounded))

                                .padding(.horizontal, 10)
                                .frame(minWidth: 70, minHeight: 24)
                                .background(Capsule().stroke(Color.white, lineWidth: 2))
                        #endif
                        Button {
                            isDark.toggle()
                        } label: {
                            Image(systemName: isDark ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.largeTitle)
                        }
                    }

                        .padding()
                        .foregroundColor(.white)
                    Spacer(minLength: 80)
                    Button(action: {

                        showNewEntry = true

                    }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))

                    }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(LinearGradient(colors: [Color.pink, Color.blue], startPoint: .leading, endPoint: .trailing))
                        .clipShape(Capsule())
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4)
                    List {
                        ForEach(items) { item in
                        ItemView(item: item)
                                .padding(.vertical,10)

                        }.onDelete { i in
                            deleteItem(i)
                        }
                    }//: List
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                        .padding(.vertical, 0)
                        .frame(maxWidth: 640)
                }//: VStack
                if(showNewEntry) {
                    BlankView().onTapGesture {
                        withAnimation {
                            showNewEntry = false
                        }
                    }
                    NewEntryView(isShowing: $showNewEntry)
                }
            }//: ZStack

                .onAppear {
                UITableView.appearance().backgroundColor = UIColor.clear
            }
                .navigationBarTitle("Daily Tasks", displayMode: .large)
                .navigationBarHidden(true)

                .background(BackgroundImageView())
                .background(backgroundGradient.ignoresSafeArea(.all))
        }//: NavigationView
        .navigationViewStyle(.stack)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, CoreDataManager.preview.persistentContainer.viewContext).previewInterfaceOrientation(.portrait)

    }
}


struct BackgroundImageView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)


    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
