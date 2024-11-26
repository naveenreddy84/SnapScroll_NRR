//
//  MainTabView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct MainTabView: View {
    let user : User
    
    var body: some View {
        
        
        
        NavigationView {
            
            TabView{
                FeedView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                SearchView()
                    .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
                UploadPostView()
                    .tabItem {
                        Image(systemName: "plus.square")
                    }
                
                NotificationsView()
                    .tabItem {
                        Image(systemName: "heart")
                    }
                
                ProfileView(user: user)
                    .tabItem {
                        Image(systemName: "person")
                    }
        
            }
            .accentColor(.black)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: logoutButton)
        }
        
    }
    
    var logoutButton: some View{
        Button{
            AuthViewModel.shared.signout()
        } label:{
            Text("Logout")
                .foregroundColor(.black)
                .bold()
        }
    }
}

