//
//  TaskModels.swift
//  ToDoTracker
//
//  Created by Wendell Richards on 3/3/26.
//

// This file will be the logic (brain) of our application

import Foundation

struct TaskItem: Identifiable, Hashable{
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable{
    let id: UUID = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

//Mock-data to test our app
extension TaskGroup{
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: "Work", symbolName: "briefcase", tasks: [
            TaskItem(title: "Finish report"),
            TaskItem(title: "Call client"),
            TaskItem(title: "Send proposal")
        ]),
        TaskGroup(title: "Personal", symbolName: "person.fill", tasks: [
            TaskItem(title: "Buy groceries")
            ]),
        TaskGroup(title: "Exercise", symbolName: "pencil", tasks: [
                TaskItem(title: "Go for a run", isCompleted: true),
                TaskItem(title: "Take a yoga class")
            ])
        ]
    
}
