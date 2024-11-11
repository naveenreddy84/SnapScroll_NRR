//
//  SnapScroll_NRRApp.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2024-10-31.
//

import SwiftUI
import Firebase

@main
struct SnapScroll_NRRApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
