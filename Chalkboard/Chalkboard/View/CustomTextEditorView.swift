//
//  CustomTextEditorView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 3/17/23.
//

import SwiftUI

struct CustomTextEditorView: View {
    
    @State var text = ""
    @State private var markdownText: String = "**DevTechie**"
    @State var isEditing = false
    
    var markdown: AttributedString {
        (try? AttributedString(markdown: markdownText)) ?? AttributedString()
    }
    
    var editedText: String {
        isEditing == true ? "**\(text)**" : text
    }
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    self.isEditing.toggle()
                } label: {
                    Text("Bold")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.lightGray))
                
                Button {
                    
                } label: {
                    Text("List")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.lightGray))
                
                Button {
                    
                } label: {
                    Text("Underline")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.lightGray))
                
                Button {
                    
                } label: {
                    Text("Light")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.lightGray))

            }
            
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxHeight: 20)
            
            TextEditor(text: $text)
                .shadow(radius: 1)
                .background(Color(UIColor.secondarySystemBackground))
                .foregroundColor(Color(.label))
                .onAppear {
                    UITextView.appearance().backgroundColor = .clear
                }
        }
        
        
    }
}

struct CustomTextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextEditorView()
    }
}
