//
//  ContentView.swift
//  Todo
//
//  Created by Mohammad Mahdi Masoudpour on 3/22/1401 AP.
//

import SwiftUI

class Todo : Identifiable{
    
    var id:UUID
    var text:String
    var title:String
    var deleted:Bool
    var dueDate:Date
    var createDate: Date
    
    init(text:String, title:String, dueDate:Date){
        self.id = UUID()
        self.title = title
        self.text = text
        self.deleted = false
        self.dueDate = dueDate
        self.createDate = Date.now
    }
    
}

struct ContentView: View {
    @State private var todos:[Todo] = [Todo(text: "abc", title: "first", dueDate: Date()), Todo(text: "bcd", title: "first2", dueDate: Date()),Todo(text: "cdf", title: "first3", dueDate: Date.now)]
    var body: some View {
        
            TabView {
                TodoListView(todoList: $todos)
                    .padding()
                    .tabItem {
                        VStack {
                            Text("Todos")
                            Image(systemName: "checklist")
                        }
                    }
                    .tag(1)
                HistoryView(todoList: $todos)
                    .padding()
                    .tabItem {
                        Text("Search")
                        Image(systemName: "magnifyingglass")
                    }
                    .tag(2)
            }
    
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
