//
//  CommentsView.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 1/8/25.
//

import SwiftUI

struct CommentsView: View {
    @State var commentText = ""
    @ObservedObject var viewModel : CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    
    var body: some View {
        VStack{
            // comment cells
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }
            }.padding(.top)
            
            //inputview
            
            CustomInputView(inputText: $commentText, action: uploadComment)
        }
    }
    
    func uploadComment(){
        viewModel.uploadComment(commentText: commentText)
        commentText = ""
        
    }
}
