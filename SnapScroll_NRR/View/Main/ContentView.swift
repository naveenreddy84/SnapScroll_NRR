//
//  ContentView.swift
//  SnapScroll
//
//  Created by Naveen Reddy Nagulapally on 2024-10-21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {

        Group{
            // if not logged in go to login else go to main tab page
            if viewModel.userSession == nil {
                LoginPage()
            } else {
                MainTabView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
