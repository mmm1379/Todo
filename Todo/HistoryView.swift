//
//  HistoryView.swift
//  Todo
//
//  Created by Mohammad Mahdi Masoudpour on 3/27/1401 AP.
//

import SwiftUI

struct HistoryView: View {
    @Binding var todoList:[Todo]
    @State private var dueDate:Date = Date().pureDay
    var body: some View {
        NavigationView{
            
            ZStack {
                VStack {
                    DatePicker(selection: $dueDate, displayedComponents: .date, label: { Text("Due Date") })
                        .padding()
                    List{
                       
                        ForEach(todoList.filter({$0.dueDate.pureDay == dueDate}).sorted(by:{$0.dueDate<$1.dueDate}), id: \.id) {todo in
                        
                            todoRowView(todo: todo)
                            
                        }.onDelete(perform: onDelete)
                            
                    }
                          
                    
                }
                if(todoList.filter({$0.dueDate.pureDay == dueDate}).count == 0){
                    Text("no item in list available")
                }
                
            }.navigationTitle("History")
        }
    }
    func onDelete(at offsets: IndexSet){
        for i in offsets.makeIterator(){
            let id = todoList.filter({$0.dueDate.pureDay == dueDate}).sorted(by:{$0.dueDate<$1.dueDate})[i].id
            let index = todoList.firstIndex(where: {$0.id == id})!
            todoList.remove(at: index)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
 
    static var previews: some View {
        HistoryView(todoList: .constant([Todo(text: "abc", title: "one", dueDate: Date().zeroSeconds), Todo(text: "bcd", title: "two", dueDate: Date().zeroSeconds),Todo(text: "cdf", title: "three", dueDate: Date.now.zeroSeconds),Todo(text: "abc", title: "four", dueDate: Date().zeroSeconds), Todo(text: "bcd", title: "five", dueDate: Date().zeroSeconds),Todo(text: "cdf", title: "six", dueDate: Date.now.zeroSeconds)]))
    }
}
