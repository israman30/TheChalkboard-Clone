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
                Text("Low")
                   .padding(4)
                   .foregroundColor(.white)
                   .background(Color.green)
                   .font(.caption)
                   .fontWeight(.bold)
                   .cornerRadius(5)
            } else if task.isMedium {
                Text("Medium")
                   .padding(4)
                   .foregroundColor(.white)
                   .background(Color.yellow)
                   .font(.caption)
                   .fontWeight(.bold)
                   .cornerRadius(5)
            } else if task.isHigh {
                Text("High")
                   .padding(4)
                   .foregroundColor(.white)
                   .background(Color.red)
                   .font(.caption)
                   .fontWeight(.bold)
                   .cornerRadius(5)
            } else {
                Text("Task")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .font(.caption)
                    .fontWeight(.bold)
                    .cornerRadius(5)
            }
        }
    }
}
