//
//  TodoListView.swift
//  Todo
//
//  Created by Mohammad Mahdi Masoudpour on 3/27/1401 AP.
//

import SwiftUI

struct TodoListView: View {
    @Binding var todoList:[Todo]
    @State private var showSortSheet:Bool = false
    @State private var sortAsc:Bool = false
    @State private var sortType:String = "Title"
    
    
    var body: some View {
        NavigationView{
            ZStack {
                List{
                    ForEach(todoList.sorted(by:sortArray), id: \.id) {todo in
                        todoRowView(todo: todo)
                    }.onDelete(perform: onDelete)
                    
                }
                
                if(todoList.count == 0){
                    Text("No item in list available")
                }
            }.navigationTitle("Todo List")
                .toolbar{
                    HStack {
                        Button(action:{
                            showSortSheet.toggle()
                        }){
                            Image(systemName: "arrow.up.arrow.down")
                        }.sheet(isPresented: $showSortSheet) {
                            SortView(sortType: $sortType, sortAsc: $sortAsc)
                        }
                        
                        NavigationLink{
                            NewTodoFormView(todoList: $todoList)
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                }
        }
    }
    func onDelete(at offsets: IndexSet){
        print(todoList)
        todoList.sort(by: sortArray)
        print(todoList)
        todoList.remove(atOffsets: offsets)
    }
    func sortArray(t1:Todo, t2:Todo) -> Bool{
        var less = false
        switch(sortType){
        case "Title": less = t1.title > t2.title
        case "Due Date": less = t1.dueDate > t2.dueDate
        case "Creation Date": less = t1.createDate > t2.createDate
            
        default:
            return true
        }
        
        return sortAsc ? !less : less
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoList: .constant([Todo(text: "abc", title: "first", dueDate: Date()), Todo(text: "bcd", title: "first2", dueDate: Date()),Todo(text: "cdf", title: "first3", dueDate: Date.now)]))
    }
}

struct SortView: View {
    @Environment(\.presentationMode) var presentationMode
    var sortOptions = ["Creation Date", "Due Date", "Title"]
    @Binding var sortType: String
    @Binding var sortAsc: Bool
    
    var body: some View {
        NavigationView{
            
            VStack{
                Picker(selection: $sortAsc, label: Text("Picker")) {
                    Text("ascending").tag(true)
                    Text("descending").tag(false)
                    
                }.pickerStyle(SegmentedPickerStyle())
                
                Picker(selection: $sortType, label: Text("Picker")) {
                    ForEach(sortOptions, id: \.self){ option in
                        Text(option).tag(option)
                    }
                }.pickerStyle(WheelPickerStyle())
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            
            
        }
    }
}

struct todoRowView: View {
    var todo:Todo
    var body: some View {
        VStack(alignment: .leading, spacing:10){
            Text(String(todo.title))
                .bold()
                .font(.title)
            
            
            Text(String(todo.text))
            Text(todo.dueDate,format:.dateTime.year().month().day().hour().minute())
                .foregroundColor(.secondary)
        }.padding()
    }
}
