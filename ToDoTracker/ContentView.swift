//
//  ContentView.swift
//  ToDoTracker
//
//  Created by Wendell Richards on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var taskGroups = TaskGroup.sampleData
    @State private var selectedGroup: TaskGroup?
    
    //Core differnce between iPhone and iPad
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility){
           //Column 1: left of navigation
            List(selection: $selectedGroup){
                ForEach(taskGroups){ group in
                    NavigationLink(value: group){
                        Label(group.title, systemImage: group.symbolName)
                    }
                    
                }
            }
            .navigationTitle("ToDo Tracker App")
            .listStyle(.sidebar)
            
        } detail: {
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id}){
                    TaskGroupDetailView(group: $taskGroups[index])
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
