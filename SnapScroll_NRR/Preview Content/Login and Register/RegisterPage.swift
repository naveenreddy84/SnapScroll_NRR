//
//  RegisterPage.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2024-11-01.
//

//
//  SignUpPage.swift
//  SnapScroll
//
//  Created by Naveen Reddy Nagulapally on 2024-10-30.
//

import SwiftUI

struct RegisterPage: View {
    
    
    @State  private var email = ""
    @State private  var password = ""
    @State private var UserName = ""
    @State private var FullName = ""
    @Environment(\.presentationMode) var mode
 
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: (Gradient(colors: [Color.purple,Color.blue])), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    
                
                VStack(spacing: 80){
                   
                       
                  
                    VStack(spacing : 20){
                        CustomTextField(text:$email, placeholder: Text("Email"), imageName:"envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal,32)
                        
                        CustomTextField(text: $UserName, placeholder: Text("User Name"), imageName: "person")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal,32)
                        
                        CustomTextField(text: $FullName, placeholder: Text("Full Name"), imageName: "person")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal,32)
                        
                        
                        
                            
                         
                        CustomSecureField(text:$password,placeholder:Text("password"),imageName: "lock")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal,32)
                    }
                   
                    VStack{
                       
                        Button(action: {}, label: {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width:360,height:50)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .padding()
                            
                            
                        })
                        
                        
                        Button(action: { mode.wrappedValue.dismiss()},
                               label: {
                            HStack{
                                Text("Already have an account?")
                                    .font(.system(size: 14,weight: .semibold))
                                Text("Login")
                                    .font(.system(size: 14,weight:.semibold))
                            }.foregroundColor(.white)
                        })
                            

                    
                    }
                  
                        
                   
                                    
                    
               
            
                    
                  
                       
                    
                }
                
            }
        }
    }
}

#Preview {
    RegisterPage()
}
