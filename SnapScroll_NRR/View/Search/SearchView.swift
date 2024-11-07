//
//  SearchView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct SearchView: View {
    @State var text: String = "Search"
    var body: some View {
        ScrollView{
            
            Text("Search View")
            SearchBar(text: $text)
            
        }
    }
}

#Preview {
    SearchView()
}
