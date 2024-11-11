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
    @State private var userName = ""
    @State private var fullName = ""
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State var imagePickerPresented = false
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: (Gradient(colors: [Color.purple,Color.blue])), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    
                VStack{
                    ZStack{
                        
                        if let image = image{
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                        } else {
                            Button(action:{imagePickerPresented.toggle()}, label: {
                                Image(systemName: "photo.badge.plus")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 140, height: 140)
                                    .foregroundColor(.white)
                            }).sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
                                ImagePicker(image: $selectedImage)
                            })
                            .padding()
                        }
                    }
                    
                    VStack(spacing : 20){
                        CustomTextField(text:$email, placeholder: Text("Email"), imageName:"envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal,32)
                        
                        CustomTextField(text: $userName, placeholder: Text("User Name"), imageName: "person")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal,32)
                        
                        CustomTextField(text: $fullName, placeholder: Text("Full Name"), imageName: "person")
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
                   
                        Button(action: {
                            viewModel.register(withEmail: email, password: password, image: selectedImage, fullname: fullName, username: userName)
                        }, label: {
                            Text("Sign Up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width:360,height:50)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .padding()
                            
                            
                        })

                  Spacer()
                    Button(action: { mode.wrappedValue.dismiss()},
                           label: {
                        HStack{
                            Text("Already have an account?")
                                .font(.system(size: 14,weight: .semibold))
                            Text("Login")
                                .font(.system(size: 14,weight:.semibold))
                        }.foregroundColor(.white)
                    })

                }.padding()
            }
        }
    }
}

extension RegisterPage{
    func loadImage(){
        guard let selectedImage = selectedImage else {return}
        image = Image(uiImage: selectedImage)
    }
}

#Preview {
    RegisterPage()
}
