//
//  AddingView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/6/22.
//

import SwiftUI

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
                TextField(LocalizablesConstants.addingTextFieldTitle, text: $vm.titleItem)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5) .stroke(Color(UIColor.secondarySystemBackground))
                    )
                    .shadow(radius: 0.2)
                    .accessibilityLabel(Text(LocalizablesConstants.addingTextFieldInputTask))
                ZStack {
                    TextEditor(text: $vm.addedItem)
                        .accessibilityHint(Text(LocalizablesConstants.addingTextEditorDescription))
                    Text(vm.addedItem).opacity(0).padding(.all, 8)
                    
                    VStack(alignment: .trailing) {
                        Spacer()
                        HStack {
                            Text("Level:")
                                .font(.callout)
                                .fontWeight(.none)
                            Spacer()
                            Button("High") {
                                self.vm.isHigh.toggle()
                                self.vm.isMedium = false
                                self.vm.isLow = false
                            }
                            .padding(4)
                            .foregroundColor(.white)
                            .background(vm.isHigh ? .red : .gray)
                            .cornerRadius(5)
                            
                            Button("Medium") {
                                self.vm.isMedium.toggle()
                                self.vm.isHigh = false
                                self.vm.isLow = false
                            }
                            .padding(4)
                            .foregroundColor(.white)
                            .background(vm.isMedium ? .yellow : .gray)
                            .cornerRadius(5)
                            
                            Button("Low") {
                                self.vm.isLow.toggle()
                                self.vm.isHigh = false
                                self.vm.isMedium = false
                            }
                            .padding(4)
                            .foregroundColor(.white)
                            .background(vm.isLow ? .green : .gray)
                            .cornerRadius(5)
                        }
                        .padding(5)
                        .font(.callout)
                        .fontWeight(.bold)
                        .opacity(!vm.addedItem.isEmpty ? 1 : 0)
                    }
                    .padding(.top)

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
                                .accessibilityHint(Text(LocalizablesConstants.addingNewTaskButtonHint))
                        }
                        .padding(.horizontal, 50)
                        .padding(.vertical, 0)
                        .frame(maxWidth: UIScreen.main.bounds.size.width)
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .disabled(!vm.titleItem.isEmpty ? false : true)
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
                        Text(LocalizablesConstants.theChalkboardNavigationTitle)
                            .font(.title)
                            .accessibilityLabel(LocalizablesConstants.theChalkboardNavigationTitle)
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
                            .accessibilityHint(Text(LocalizablesConstants.closingButtonDescriptionHint))
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
