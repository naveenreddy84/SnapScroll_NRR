//
//  ContentView.swift
//  SnapScroll
//
//  Created by Naveen Reddy Nagulapally on 2024-10-21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedIndex = 0
    
    var body: some View {
        
        Group{
            // if not logged in go to login else go to main tab page
            if viewModel.userSession == nil {
                LoginPage()
            } else {
                if let user = viewModel.currentUser{
                    MainTabView(user: user, selectedIndex: $selectedIndex)
                }
                
            }
        }
    }
    
    
}
