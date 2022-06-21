//
//  NewTodoFormView.swift
//  Todo
//
//  Created by Mohammad Mahdi Masoudpour on 3/27/1401 AP.
//

import SwiftUI

struct NewTodoFormView: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var todoList:[Todo]

    @State private var title:String = ""
    @State private var text:String = ""
    @State private var dueDate:Date = Date()
    var body: some View {
            
            Form{
                TextField("Title", text: $title)
                TextField("Text", text: $text)
                DatePicker(selection: $dueDate, label: { Text("Due Date") })
                
            }.toolbar{
                Button("submit") {
                    todoList.append(Todo(text: text, title: title, dueDate: dueDate.zeroSeconds))
                    presentationMode.wrappedValue.dismiss()

                }.disabled(title.count == 0 || text.count == 0)
            }
            
        
    }
}

struct NewTodoFormView_Previews: PreviewProvider {
    
    static var previews: some View {
        NewTodoFormView(todoList: .constant([]))
    }
}
