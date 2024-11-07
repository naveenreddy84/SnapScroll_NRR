//
//  FeedView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(0 ..< 10){ _ in
                    FeedCell()
                }
                
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider{
    static var previews: some View{
        FeedView()
    }
}
