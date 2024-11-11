//
//  NotificationsView.swift
//  SnapScroll
//
//  Created by Prashanth Muppa on 10/28/24.
//

import SwiftUI

struct NotificationsView: View {
    
    
    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(0 ..< 20){ _ in
                    NotificationCell()
                        .padding(.top)
                    
                }
            }
        }
    }
}

#Preview {
    NotificationsView()
}
