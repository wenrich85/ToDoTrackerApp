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
    
    @State private var isShowingAddGroup: Bool = false
    
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
            .toolbar {
                Button {
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
        } detail: {
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == group.id}){
                    TaskGroupDetailView(group: $taskGroups[index])
                }else{
                    ContentUnavailableView("Select a group", systemImage: "sidebar.left")
                }
            }
        }
        .sheet(isPresented: $isShowingAddGroup){
            NewGroupView { newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup
            }
        }
    }
}

#Preview {
    ContentView()
}
