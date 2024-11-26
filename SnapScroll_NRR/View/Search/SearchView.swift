//
//  SearchView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var inSearchMode = false
    
    @ObservedObject var viewModel  = SearchViewModel()
    
    var body: some View {
        ScrollView{
            
        SearchBar(text: $searchText, isEditing: $inSearchMode)
                .padding()
            
            ZStack{
                if inSearchMode {
                    UserListView(viewModel: viewModel,  searchText: $searchText)
                }
                else{
                    PostGridView()
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
