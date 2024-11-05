//
//  UserStatView.swift
//  SnapScroll_NRR
//
//  Created by Rajesh Begari on 11/4/24.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        
        VStack{
            Text("\(value)")
                .font(.system(size: 15, weight: .semibold))
            
            Text("Followers")
                .font(.system(size: 15))
        }
        .frame(width: 80, alignment: .center)
    }
}

struct UserStatView_Previews: PreviewProvider{
    static var previews: some View{
        UserStatView(value: 1, title: "Post")
    }
}
