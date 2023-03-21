//
//  AddingView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/6/22.
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
    
    static let addingTextFieldTitle = NSLocalizedString("Accessibility_adding_title", comment: "Title")
    static let addingTextFieldInputTask = NSLocalizedString("Accessibility_input_task", comment: "Input task")
    static let addingTextEditorDescription = NSLocalizedString("Accessibility_input description", comment: "Input description")
    static let addingImportantDescription = NSLocalizedString("Accessibility_important", comment: "Important")
    static let addingImportantDescriptionHint = NSLocalizedString("Accessibility_tap_for_make_the_task_important", comment: "tap for make the task important")
    static let closingButtonDescriptionHint = NSLocalizedString("Accessibility_tap_for_closing_page", comment: "tap for closing page")
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
                            Spacer()
                            Button {
                                self.vm.isPriority.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: vm.isPriority ? "checkmark" : "exclamationmark.circle")
                                    Text(LocalizablesConstants.addingImportantDescription)
                                }
                                .font(.system(size: 12))
                                .foregroundColor(Color(.label))
                                .accessibilityHint(Text(LocalizablesConstants.addingImportantDescriptionHint))
                            }
                            .padding(5)
                            .buttonStyle(.bordered)
                            .tint(vm.isPriority ? .red : .clear)
                            .opacity(!vm.addedItem.isEmpty ? 1 : 0)
                            
                        }
                        
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
