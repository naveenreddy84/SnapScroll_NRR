//
//  SearchView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = "" // Search text binding
    @State private var inSearchMode = false // Search mode state
    
    @ObservedObject var viewModel = SearchViewModel() // ViewModel for search
    
    var body: some View {
        ScrollView {
            // Search bar for text input and managing editing state
            SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
            // Show different views based on search mode
            ZStack {
                if inSearchMode {
                    // Show the user list view if in search mode
                    UserListView(viewModel: viewModel, searchText: $searchText)
                        .transition(.opacity) // Smooth transition to user list
                } else {
                    // Show the post grid when not in search mode
                    PostGridView(config: .explore)
                }
            }
            .onChange(of: searchText) { newText in
                // Automatically switch to search mode if the user starts typing
                if !newText.isEmpty && !inSearchMode {
                    withAnimation {
                        inSearchMode = true
                    }
                } else if newText.isEmpty && inSearchMode {
                    // Switch back to the default view when search text is cleared
                    withAnimation {
                        inSearchMode = false
                    }
                }
            }
        }
    }
}



struct SearchView_previews : PreviewProvider{
    static var previews: some View{
        SearchView()
    }
}
