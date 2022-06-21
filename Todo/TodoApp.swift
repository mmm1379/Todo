//
//  TodoApp.swift
//  Todo
//
//  Created by Mohammad Mahdi Masoudpour on 3/22/1401 AP.
//

import SwiftUI

@main
struct TodoApp: App {
    var body: some Scene {
        WindowGroup{
            ContentView()
        }
    }
}

extension Date {

    var zeroSeconds: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return calendar.date(from: dateComponents)!
    }
    var pureDay: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: dateComponents)!
    }

}


        
