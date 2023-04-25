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
    let notification: NotificationManagerViewModel = .instance
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
                        HStack {
                            VStack {}
                                .frame(maxHeight: .infinity)
                                .frame(width: 1)
                                .background(Color.customGreen)
                                .padding(.leading, -10)
//                                .opacity(task.isPriority ? 1 : 0)

                            VStack(alignment: .leading, spacing: 5) {
                                Text(task.title ?? LocalizablesConstants.mainNotItemLabel)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .strikethrough(task.isCompleted, color: .red)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        task.isCompleted.toggle()
                                        self.save()
                                    }
                                    .accessibilityHint(Text(LocalizablesConstants.mainListStrikethroughLabel))
                                Text(task.name ?? LocalizablesConstants.mainNotTitleLabel)
                                    .font(.body)
                                    .fontWeight(.light)
                                    .strikethrough(task.isCompleted, color: .red)
                                
                                
                                HStack {
                                    Text(task.timestamp ?? LocalizablesConstants.mainNotDateLabel)
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                     
                                    LevelSection(task: task)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .padding(5)
            .listStyle(.grouped)
            .navigationBarTitle(LocalizablesConstants.theChalkboardNavigationTitle)
            .accessibilityAddTraits(.isHeader)
            .accessibilityHeading(.h1)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .accessibilityHint(Text(LocalizablesConstants.deletingGroupButtonHint))
                        .disabled(tasks.isEmpty ? true : false)
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        self.isShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(.label))
                            .font(.title3)
                            .frame(height: 96, alignment: .trailing)
                            .accessibilityHint(Text(LocalizablesConstants.addingNewTaskButtonHint))
                    }
                }
            }
            .onAppear {
                notification.requestAuthorization()
                notification.removeNotificaion()
            }
            .fullScreenCover(isPresented: $isShowing, content: {
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
