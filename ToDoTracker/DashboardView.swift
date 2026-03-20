//
//  DashboardView.swift
//  ToDoTracker
//
//  Created by Wendell Richards on 3/17/26.
//

import SwiftUI

struct DashboardView: View {
    @State private var profile: [Profile] = Profile.sample
    @State private var path = NavigationPath()
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                ScrollView{
                    VStack{
                        VStack(spacing: 10){
                            Text("Welcome Back")
                                .font(.headline)
                                .textCase(.uppercase)
                            Text("Who is working today")
                                .font(.subheadline)
                        }
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach($profile) { $profile in
                                NavigationLink(value: profile) {
                                    Image(profile.profileImage)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 22))
                                    
                                    Text(profile.name)
                                        .fontWeight(.bold)
                                        .foregroundColor(.orange)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: Profile.self) { selectedProfile in
                if let index = profile.firstIndex(where: {$0.id == selectedProfile.id}){
                    ContentView(profile: $profile[index])
                }
            }
        }
    }
}
