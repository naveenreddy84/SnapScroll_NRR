//
//  CommentsView.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 1/8/25.
//

import SwiftUI

struct CommentsView: View {
    @State var commentText = ""
    
    
    var body: some View {
        VStack{
            // comment cells
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(0 ..< 10) { _ in
                        CommentCell()
                    }
                }
            }.padding(.top)
            
            //inputview
            
            CustomInputView(inputText: $commentText, action: uploadComment)
        }
    }
    
    func uploadComment(){
        
        
    }
}

#Preview {
    CommentsView()
}
