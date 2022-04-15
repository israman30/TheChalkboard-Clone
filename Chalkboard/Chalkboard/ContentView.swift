//
//  ContentView.swift
//  Chalkboard
//
//  Created by Israel Manzo on 4/2/22.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID().uuidString
    let title: String
    let date: String
}

class ItemViewModel: ObservableObject {
    
    @Published var items = [Item]()
    @Published var isShowing = false
    
    func addingItem(item: Item) {
        items.append(item)
    }
}

struct ContentView: View {
    
    @State var input = ""
    @StateObject var vm = ItemViewModel()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp)]) var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks) { task in
                        VStack(alignment: .leading) {
                            Text(task.name ?? "NO TITLE")
                                .font(.title)
                            Text(task.timestamp ?? "NO DATE")
                                .font(.footnote)
                        }
                    }
                }
            }
            .padding(5)
            .listStyle(.grouped)
            .navigationBarTitle("The Chalkboard")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        self.vm.isShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(.label))
                            .font(.title3)
                            .frame(height: 96, alignment: .trailing)
                    }
                }
                
            }
            .sheet(isPresented: $vm.isShowing, content: {
                AddingView()
            })
            
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
