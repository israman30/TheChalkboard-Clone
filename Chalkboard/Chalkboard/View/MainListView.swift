//
//  MainListView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 3/14/23.
//

import SwiftUI

struct MainListView: View {
    @State var input = ""
    @State var isShowing = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp)]) var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
                        HStack {
                            VStack {}
                                .frame(maxHeight: .infinity)
                                .frame(width: 5)
                                .background(task.isPriority ? .red : Color(.systemGray4))
                                .padding(.leading, -10)
//                                .opacity(task.isPriority ? 1 : 0)
                            
                            VStack(alignment: .leading) {
                                Text(task.title ?? "NO ITEM")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .strikethrough(task.isCompleted, color: .red)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        task.isCompleted.toggle()
                                        self.save()
                                    }
                                    .accessibilityHint(Text("tap for strikethrough if task is completed"))
                                Text(task.name ?? "NO TITLE")
                                    .font(.body)
                                    .fontWeight(.light)
                                    .strikethrough(task.isCompleted, color: .red)
                                Text(task.timestamp ?? "NO DATE")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .padding(5)
            .listStyle(.grouped)
            .navigationBarTitle("The Chalkboard")
            .accessibilityAddTraits(.isHeader)
            .accessibilityHeading(.h1)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .accessibilityHint(Text("tap for deleting in group"))
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        self.isShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(.label))
                            .font(.title3)
                            .frame(height: 96, alignment: .trailing)
                            .accessibilityHint(Text("tap for adding a new task"))
                    }
                }
            }
            .sheet(isPresented: $isShowing, content: {
                AddingView()
            })
            
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteTask(at offset: IndexSet) {
        offset.forEach { index in
            let task = tasks[index]
            moc.delete(task)
        }
        save()
    }
    
    private func save() {
        do {
            try moc.save()
        } catch {
            print("Error saving task in db: \(error.localizedDescription)")
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
