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
//                    ForEach(tasks) { item in
                        ForEach(data, id: \.self) { item in
                            ZStack {
                                VStack {
                                    HStack {
                                        Spacer()
                                        Image(systemName: "trash")
                                            .padding(5)
                                            
                                    }
                                    Spacer()
                                }
                                
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        // Text(item.title ?? "No title")
                                        Text("Title goes here in this spot")
                                            .padding(.vertical, 2)
                                            .font(.title3)
                                            .fontWeight(.medium)
                                    }

        //                            Text(item.name ?? "No body")
                                    Text("Body goes here in this type of body")
                                        .font(.body)
                                        .fontWeight(.light)
                                    Spacer()
        //                            Text(item.timestamp ?? "time")
                                    Text("10/20/2023")
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
                        
                        
                        
                    }
//                    .onDelete(perform: deleteTask)
                    .onDelete { indexSet in
                        deleteTask(at: indexSet)
                    }
                    
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


struct Delete: ViewModifier {
    
    let action: () -> Void
    
    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var contentWidth: CGFloat = 0.0
    @State var willDeleteIfReleased = false
   
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    ZStack {
                        Rectangle()
                            .foregroundColor(.red)
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                            .font(.title2.bold())
                            .layoutPriority(-1)
                    }.frame(width: -offset.width)
                    .offset(x: geometry.size.width)
                    .onAppear {
                        contentWidth = geometry.size.width
                    }
                    .gesture(
                        TapGesture()
                            .onEnded {
                                delete()
                            }
                    )
                }
            )
            .offset(x: offset.width, y: 0)
            .gesture (
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width + initialOffset.width <= 0 {
                            self.offset.width = gesture.translation.width + initialOffset.width
                        }
                        if self.offset.width < -deletionDistance && !willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        } else if offset.width > -deletionDistance && willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        }
                    }
                    .onEnded { _ in
                        if offset.width < -deletionDistance {
                            delete()
                        } else if offset.width < -halfDeletionDistance {
                            offset.width = -tappableDeletionWidth
                            initialOffset.width = -tappableDeletionWidth
                        } else {
                            offset = .zero
                            initialOffset = .zero
                        }
                    }
            )
            .animation(.interactiveSpring())
    }
    
    private func delete() {
        offset.width = -contentWidth
        action()
    }
    
    private func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    //MARK: Constants
    
    let deletionDistance = CGFloat(200)
    let halfDeletionDistance = CGFloat(50)
    let tappableDeletionWidth = CGFloat(100)
    
    
}

extension View {
    
    func onDelete(perform action: @escaping () -> Void) -> some View {
        self.modifier(Delete(action: action))
    }
    
}
