//
//  UserFollowView.swift
//  SnapScroll_NRR
//
//  Created by Prashanth Muppa on 1/15/25.
//

import SwiftUI
import Kingfisher

struct UserFollowView: View {
    let title: String
    let users: [User]

    var body: some View {
        VStack {
//            Text(title)
//                .font(.headline)
//                .padding()

            List(users) { user in
                HStack {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                    Text(user.username)
                        .font(.system(size: 16, weight: .semibold))

                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
