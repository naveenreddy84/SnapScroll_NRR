//
//  CustomSecureField.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2024-11-01.
//


import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder : Text
    let imageName : String
  
    
    var body: some View {
        ZStack(alignment:.leading){
            if(text.isEmpty){
                placeholder
                    .foregroundColor(Color(.init(white: 1, alpha: 0.8)))
                    .padding(.leading, 40)
                
            }
            HStack{
                Image(systemName : imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width:20, height: 20)
                    .foregroundColor(.white)
                
                SecureField("", text: $text)
               
            }
        }
    }
}
