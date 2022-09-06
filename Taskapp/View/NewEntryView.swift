//
//  NewEntryView.swift
//  Taskapp
//
//  Created by Benjamin on 05/09/2022.
import SwiftUI

struct NewEntryView: View {
    //MARK: - Properties
    @AppStorage("isDark") var isDark: Bool = false
    @State var task: String = ""
    @Binding var isShowing: Bool
    @Environment(\.managedObjectContext) private var viewContext
    private func addItem() {
        withAnimation {
            
            //            if(task.isEmpty) { return }
            let item = Item(context: viewContext)
            item.dateCreated = Date()
            item.task = task
            item.completion = false
            item.id = UUID()
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
            
            task = ""
            UIApplication.shared.hideKeyboard()
            isShowing = false
        }

    }

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {


                TextField("New Task", text: $task)
                    .padding()
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .background(isDark ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                Button {
                    addItem()
                } label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                }
                    .disabled(task.isEmpty)
                    .padding()
                    .foregroundColor(.white)
                    .background(task.isEmpty ? Color.blue : Color.pink)
                    .cornerRadius(10)
            }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .background(isDark ? Color(UIColor.secondarySystemBackground) : Color.white)
                .cornerRadius(16)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 12)
                .frame(maxWidth: 640)
        }//: VStack
        .padding()
    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView(isShowing: .constant(true)).environment(\.managedObjectContext, CoreDataManager.preview.persistentContainer.viewContext)
    }
}


struct BlankView: View {
    var body: some View {
        VStack {
            Spacer()
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.black)
            .opacity(0.5)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
