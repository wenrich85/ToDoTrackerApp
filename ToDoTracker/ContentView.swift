//
//  ContentView.swift
//  ToDoTracker
//
//  Created by Wendell Richards on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var taskGroups: [TaskGroup] = []
    @State private var selectedGroup: TaskGroup?
    
    //Core differnce between iPhone and iPad
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    @State private var isShowingAddGroup: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("isDarkMode") private var isDarkMode: Bool = true
    
    let saveKey = "SavedTaskGroups"
    
    @Environment(\.dismiss) private var dismiss
    @Binding var profile: Profile
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility){

           //Column 1: left of navigation
            List(selection: $selectedGroup){
                ForEach(profile.groups){ group in
                    NavigationLink(value: group){
                        Label(group.title, systemImage: group.symbolName)
                    }
                    .accessibilityIdentifier("GroupLink_\(group.title)")
                    
                }
            
            }
            .navigationTitle(profile.name)
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        isDarkMode.toggle()
                    } label: {
                        Image(systemName: !isDarkMode ? "moon.fill" : "sun.max.fill")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("ToDoTitle")
                }
            }
            
        } detail: {
            if let group = selectedGroup {
                if let index = profile.groups.firstIndex(where: { $0.id == group.id}){
                    TaskGroupDetailView(group: $profile.groups[index])
                }else{
                    ContentUnavailableView("Select a group", systemImage: "sidebar.left")
                }
            }
        }
        .sheet(isPresented: $isShowingAddGroup){
            NewGroupView { newGroup in
                profile.groups.append(newGroup)
                selectedGroup = newGroup
            }
        }
        .onAppear{
            loadData() // New Func
        }
        .onChange(of: scenePhase){ oldValue, newValue in
            if newValue == .active{
                print("App is active")
            } else if newValue == .inactive {
                print("App is inactive")
            } else if newValue == .background {
                print("Background state, saving data...")
                saveData() // new function
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    func loadData() {
        // check if there is any data to take the infromation from
        if let savedData = UserDefaults.standard.data(forKey: saveKey){
            // Extract the info
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: savedData){
                profile.groups = decodedGroups
                return
            }
        }
        if profile.groups.isEmpty {
            profile.groups = TaskGroup.sampleData // Default data if there is no saved data

        }
    }
    
    
    func saveData() {
        if let encodedGroups = try? JSONEncoder().encode(profile.groups){
            UserDefaults.standard.set(encodedGroups, forKey: saveKey)
        }
    }
}

#Preview {
//    ContentView()
}
