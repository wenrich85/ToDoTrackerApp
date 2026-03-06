//
//  NewGroupView.swift
//  ToDoTracker
//
//  Created by Wendell Richards on 3/5/26.
//

import SwiftUI

struct NewGroupView: View {
    @State private var groupName: String = ""
    @State private var selectedIcon: String = "list.bullet"
    
    let icons: [String] = ["list.bullet", "bookmark.fill", "star", "house.fill", "heart.fill"]
    
    @Environment(\.dismiss) var dismiss
    var onSave: (TaskGroup) -> Void
    
    
    var body: some View {
        NavigationStack{
            Form {
                //Section: Group Name
                Section("Group Name"){
                    TextField("e.g. Work, School", text: $groupName)
                }///Section: Group Name
                
                //Section2: selected Icon
                Section("Select Icon"){
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]){
                        ForEach(icons, id: \.self){icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .background(selectedIcon == icon ? Color.pink.opacity(0.2) : Color.clear)
                                .foregroundStyle(selectedIcon == icon ? Color.blue : Color.gray)
                                .clipShape(Circle())
                                .onTapGesture{
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical)
                }///Section2: selected Icon
            }
            .navigationTitle("New Group")
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){dismiss()}
                }
                
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        let newGroup = TaskGroup(title: groupName, symbolName: selectedIcon, tasks: [])
                        onSave(newGroup)
                        dismiss()
                    }
                }
            }
        }
        
    }
}


