//
//  FeedView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(viewModel.posts){post in
                    FeedCell(post: post)
                }
                
            }.padding(.top)
        }
    }
}

struct FeedView_Previews: PreviewProvider{
    static var previews: some View{
        FeedView()
    }
}
