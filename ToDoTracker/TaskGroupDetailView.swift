//
//  TaskGroupDetailView.swift
//  ToDoTracker
//
//  Created by Wendell Richards on 3/3/26.
//

// Detatils that are shown on the right screen of the iPad

import SwiftUI

struct TaskGroupDetailView: View {
    @Binding var group: TaskGroup
    
    var body: some View {
        List {
            ForEach($group.tasks){ $task in
                HStack {
                    Image(systemName: task.isCompleted ?
                          "checkmark.circle.fill" : "circle")
                    .foregroundStyle(task.isCompleted ? .blue : .primary)
                    .onTapGesture {
                        withAnimation{
                            task.isCompleted.toggle()
                        }
                    }
                    TextField("Task Title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .gray : .primary)
                }
                
            }.onDelete{ index in
                group.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(group.title)
        .toolbar {
            Button("Add Task")
            {
                withAnimation{
                    group.tasks.append(TaskItem(title: ""))
                }
            }
        }
    }
}
