//
//  AddingView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/6/22.
//

import SwiftUI

struct AddingView: View {
    
    @State var addedItem = ""
    @State private var date = Date()
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @ObservedObject private var keyboard = KeyboardResponder()
    @StateObject private var keyboardHandler = KeyboardHandler()
//    var item: (Item) -> ()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack {
            headerSection

            VStack {
                ZStack {
                    TextEditor(text: $addedItem)
                    Text(addedItem).opacity(0).padding(.all, 8)
                }
                .shadow(radius: 1)
                    .background(Color(UIColor.secondarySystemBackground))
                    .foregroundColor(Color(.label))
                    .accessibilityLabel("\(addedItem)")
                    .onAppear {
                        UITextView.appearance().backgroundColor = .clear
                    }
                
                HStack {
                    Button {
                        print("Added item")
                        self.add()
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
                    .disabled(!addedItem.isEmpty ? false : true)
                    .controlSize(.large)
                    .padding(.bottom, keyboard.currentHeight)
//                    .padding(.bottom, keyboardHandler.keyboardHeight)
                }
            }
            Spacer()
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        
    }
    
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
                        
                        Text("\(dateFormatter.string(from: date))")
                    }
                    
                    Spacer()
                    
                    Button {
                        self.close()
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
                    DatePicker("", selection: $date)
                }
                .padding(.top, -5)
            }
            Spacer()
        }
    }
    
    private func add() {
//        let item = Item(title: addedItem, date: dateFormatter.string(from: date))
//        self.item(item)
        let newTask = Task(context: moc)
        newTask.id = UUID()
        newTask.name = addedItem
        newTask.timestamp = dateFormatter.string(from: date)
        try? moc.save()
        close()
    }
    
    private func close() {
        self.addedItem = ""
        self.dismiss()
    }
    
}

struct AddingView_Previews: PreviewProvider {
    static var previews: some View {
        AddingView()
    }
}
