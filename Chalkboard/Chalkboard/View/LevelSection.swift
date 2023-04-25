//
//  LevelSection.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/23/23.
//

import SwiftUI

struct LevelSection: View {
    
    let task: Task
    
    var body: some View {
        HStack {
            if task.isLow {
                TagView(text: "Low", color: .green)
            } else if task.isMedium {
                TagView(text: "Medium", color: .yellow)
            } else if task.isHigh {
                TagView(text: "High", color: .red)
            } else {
                TagView(text: "Task", color: .gray)
            }
        }
        .font(.body)
        .foregroundColor(.white)
    }
}

struct TagView: View {
    let text: String
    let color: Color
    var body: some View {
        Text(text)
            .padding(4)
            .background(color)
            .fontWeight(.bold)
            .cornerRadius(5)
    }
}
