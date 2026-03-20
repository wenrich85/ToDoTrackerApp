//
//  TaskModels.swift
//  ToDoTracker
//
//  Created by Wendell Richards on 3/3/26.
//

// This file will be the logic (brain) of our application

import Foundation

struct TaskItem: Identifiable, Hashable, Codable{
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TaskGroup: Identifiable, Hashable, Codable{
    var id: UUID = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

struct Profile: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var profileImage: String
    var groups: [TaskGroup]
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

extension Profile {
    static let sample: [Profile] = [
        Profile(name: "Professor", profileImage: "Professor_img", groups: TaskGroup.sampleData),
        Profile(name: "Student", profileImage: "Student_img", groups: [])
    ]
}
