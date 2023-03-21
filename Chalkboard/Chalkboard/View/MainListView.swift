//
//  MainListView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 3/14/23.
//

import SwiftUI

struct LocalizablesConstants {
    static let mainListStrikethroughLabel = NSLocalizedString("Accessibility_tap_for_strikethrough_if_task_is_completed", comment: "tap for strikethrough if task is completed")
    static let mainNotItemLabel = NSLocalizedString("Accessibility_no_item", comment: "NO ITEM")
    static let mainNotTitleLabel = NSLocalizedString("Accessibility_no_title", comment: "NO TITLE")
    static let mainNotDateLabel = NSLocalizedString("Accessibility_no_date", comment: "NO DATE")
    static let theChalkboardNavigationTitle = NSLocalizedString("Accessibility_The_Chalkboarde", comment: "The Chalkboard")
    static let deletingGroupButtonHint = NSLocalizedString("Accessibility_tap_for_deleting_in_group", comment: "tap for deleting in group")
    static let addingNewTaskButtonHint = NSLocalizedString("Accessibility_tap_for_adding_a_new_task", comment: "tap for adding a new task")
}

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
                                Text(task.title ?? LocalizablesConstants.mainNotItemLabel)
                                    .font(.title3)
                                    .fontWeight(.medium)
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
                                Text(task.timestamp ?? LocalizablesConstants.mainNotDateLabel)
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
            .navigationBarTitle(LocalizablesConstants.theChalkboardNavigationTitle)
            .accessibilityAddTraits(.isHeader)
            .accessibilityHeading(.h1)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .accessibilityHint(Text(LocalizablesConstants.deletingGroupButtonHint))
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
