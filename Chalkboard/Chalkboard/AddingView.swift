//
//  AddingView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/6/22.
//

import SwiftUI

struct AddingView: View {
    
    @State var scale = 1.0
    @State var addedItem = ""
    @State private var date = Date()
    @FocusState private var focusState: Bool
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var keyboard = KeyboardResponder()
    @StateObject private var keyboardHandler = KeyboardHandler()
    var item: (Item) -> ()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment:.leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("The Chalkboard")
                                .font(.title)
                                .accessibilityLabel("The Chalkboard")
                                .accessibilityAddTraits(.isHeader)
                                .accessibilityHeading(.h1)
                            Text("Add an item")
                                .font(.title3)
                                .accessibilityHeading(.h2)
                            
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
            VStack {
                TextEditor(text: $addedItem)
                    .focused($focusState)
                    .background(Color(UIColor.secondarySystemBackground))
                    .foregroundColor(Color(.label))
                    .accessibilityLabel("\(addedItem)")
                    .onAppear {
                        UITextView.appearance().backgroundColor = .clear
                    }
//                    .animation(.linear, value: scale)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("Done") {
                                self.focusState = false
                            }
                        }
                    }
                    .gesture(DragGesture().onChanged({ _ in
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }))
                
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
                        .padding(.vertical, 5)
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
    
    private func add() {
        let item = Item(title: addedItem, date: dateFormatter.string(from: date))
        self.item(item)
        close()
    }
    
    private func close() {
        self.addedItem = ""
        self.presentationMode.wrappedValue.dismiss()
    }
    
}

struct AddingView_Previews: PreviewProvider {
    static var previews: some View {
        AddingView { i in

        }
    }
}
