//
//  ContentView.swift
//  SnapScroll
//
//  Created by Naveen Reddy Nagulapally on 2024-10-21.
//

/*
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
 */


import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showSplashScreen = true
    @State private var selectedIndex = 0

    var body: some View {
        ZStack {
            
            if !showSplashScreen {
                Group {
                    if viewModel.userSession == nil {
                      
                        LoginPage()
                    } else {
                        if let user = viewModel.currentUser {
                            
                            MainTabView(user: user, selectedIndex: $selectedIndex)
                        }
                    }
                }
            }

           
            if showSplashScreen {
                SplashScreenView()
                    .onAppear {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            }
        }
        .animation(.easeInOut, value: showSplashScreen)
    }
}


struct SplashScreenView: View {
    var body: some View {
        VStack {
           
            Text("SnapScroll")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding()

          
            Image("SnapScrollLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}




