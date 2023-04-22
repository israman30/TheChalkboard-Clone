//
//  MainGridView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/21/23.
//

import SwiftUI

struct MainGridView: View {
    @State var input = ""
    @State var isShowing = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp)]) var tasks: FetchedResults<Task>
    let notification: NotificationManagerViewModel = .instance
    
    var data = Array(1...20)
    var colors: [Color] = [.red, .green, .yellow, .blue]
    
    var adaptiveColumns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 2)
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                    ForEach(tasks) { item in
//                        ForEach(data, id: \.self) { item in
                        VStack(alignment: .leading) {
                            Text(item.title ?? "No title")
//                            Text("Title goes here in this spot")
                                .padding(.vertical, 2)
                                .font(.title3)
                                .fontWeight(.medium)
                            Text(item.name ?? "No body")
//                            Text("Body goes here in this type of body")
                                .font(.body)
                                .fontWeight(.light)
                            Spacer()
                            Text(item.timestamp ?? "time")
//                            Text("10/20/2023")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        .frame(height: 150)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 1), lineWidth: 1)
                        }
                        .onTapGesture {
                            print("tap")
                        }
                        
                        
                    }
                    .onDelete(perform: deleteTask)
                    
                }
                .padding()
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
                .fullScreenCover(isPresented: $isShowing) {
                    AddingView()
                }
            }
            .navigationTitle("The Chalkboard")
        }
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

struct MainGridView_Previews: PreviewProvider {
    static var previews: some View {
        MainGridView()
    }
}
