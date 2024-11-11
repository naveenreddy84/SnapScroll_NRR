//
//  LoginPage.swift
//  SnapScroll_NRR
//
//  Created by Naveen Reddy Nagulapally on 2024-11-01.
//

import SwiftUI

struct LoginPage: View {
    
    @State  private var email = ""
    @State private  var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
   
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: (Gradient(colors: [Color.purple,Color.blue])), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    
                
                VStack(spacing: 80){
                    Text("SnapScroll")
                        .font(.custom("HelveticaNeue-Bold", size: 32))
                        .foregroundColor(.white)
                        .padding(.top, 50)
                       
                  
                    VStack(spacing : 20){
                        CustomTextField(text:$email, placeholder: Text("Email"), imageName:"envelope")
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
                    
                    HStack {
                        Spacer()
                          Button(action: {}, label: {
                              Text("Forgot Password?")
                                  .font(.system(size: 13,weight: .semibold))
                                  .foregroundColor(.white)
                                  .padding(.top)
                                  .padding(.trailing,28)
                          })
                         
                      }
                    VStack{
                        Button(action: {
                            viewModel.login(withEmail: email, password: password)
                        }, label: {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width:360,height:50)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .padding()
                            
                            
                        })
                        
                        
                        NavigationLink(destination:RegisterPage().navigationBarBackButtonHidden(true),
                                       label: {
                            
                            HStack{
                                Text("Dont have an account?")
                                    .font(.system(size: 14,weight: .semibold))
                                Text("Sign Up")
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
    LoginPage()
}

