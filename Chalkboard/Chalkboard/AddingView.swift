//
//  AddingView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/6/22.
//

import SwiftUI
import CoreData

struct NewItem {
    let item: String = ""
    let date = Date()
}

class ItemViewModel: ObservableObject {
    var context: NSManagedObjectContext?
    private let newItem = NewItem()
    @Published var addedItem = ""
    @Published var date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }
    
    init(context: NSManagedObjectContext? = nil) {
        self.context = context
    }
    
    func add() {
        let newTask = Task(context: context!)
        newTask.id = UUID()
        newTask.name = addedItem
        newTask.timestamp = dateFormatter.string(from: date)
        save()
        close()
    }
    private func save() {
        do {
            try context!.save()
        } catch {
            print("Error saving task in db: \(error.localizedDescription)")
        }
    }
    
    func close() {
        self.addedItem = ""
    }
}

struct AddingView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @ObservedObject private var keyboard = KeyboardResponder()
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    @StateObject private var vm = ItemViewModel()
    
    var body: some View {
        VStack {
            headerSection

            VStack {
                ZStack {
                    TextEditor(text: $vm.addedItem)
                    Text(vm.addedItem).opacity(0).padding(.all, 8)
                }
                .shadow(radius: 1)
                    .background(Color(UIColor.secondarySystemBackground))
                    .foregroundColor(Color(.label))
                    .accessibilityLabel("\(vm.addedItem)")
                    .onAppear {
                        UITextView.appearance().backgroundColor = .clear
                    }
                
                HStack {
                    Button {
                        print("======== Added item =======")
                        self.vm.add()
                        self.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                            Text("Add")
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal, 50)
                        .padding(.vertical, 0)
                        .frame(maxWidth: UIScreen.main.bounds.size.width)
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .disabled(!vm.addedItem.isEmpty ? false : true)
                    .controlSize(.large)
                    .padding(.bottom, keyboard.currentHeight)
//                    .padding(.bottom, keyboardHandler.keyboardHeight)
                }
            }
            Spacer()
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            self.vm.context = moc
        }
        
    }
    
}

struct AddingView_Previews: PreviewProvider {
    static var previews: some View {
        AddingView()
    }
}

extension AddingView {
    private var headerSection: some View {
        HStack {
            VStack(alignment:.leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("The Chalkboard")
                            .font(.title)
                            .accessibilityLabel("The Chalkboard")
                            .accessibilityAddTraits(.isHeader)
                            .accessibilityHeading(.h1)
                        
                        Text("\(vm.dateFormatter.string(from: vm.date))")
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button {
                        self.vm.close()
                        self.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.label))
                            .font(.title3)
                            .padding(10)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(20)
                            .offset(y:-10)
                    }
                }
                HStack(alignment: .center) {
                    Spacer()
                    DatePicker("", selection: $vm.date)
                }
                .padding(.top, -5)
            }
            Spacer()
        }
    }
}
