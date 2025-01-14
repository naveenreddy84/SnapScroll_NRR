//
//  SearchBar.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            // TextField for search input
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                )
                .onTapGesture {
                    // Activate search mode when tapping the TextField
                    if !isEditing {
                        isEditing = true
                    }
                }
            
            // Cancel button is visible when editing
            if isEditing {
                Button(action: {
                    // Clear the search text and exit search mode
                    withAnimation {
                        isEditing = false
                    }
                    text = ""
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                })
                .padding(.trailing, 8)
                .transition(.move(edge: .trailing)) // Smooth transition for cancel button
            }
        }
        .padding(.top, 8) // Ensure proper padding for a smooth experience
    }
}


#Preview {
    SearchBar(text: .constant("Text"), isEditing: .constant(true))
}
