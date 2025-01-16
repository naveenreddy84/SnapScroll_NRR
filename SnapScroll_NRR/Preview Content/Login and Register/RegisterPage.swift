//import SwiftUI
//
//struct RegisterPage: View {
//    
//    @State private var email = ""
//    @State private var password = ""
//    @State private var userName = ""
//    @State private var fullName = ""
//    @State private var selectedImage: UIImage?
//    @State private var image: Image?
//    @State private var imagePickerPresented = false
//    @State private var errorMessage: String?  // To store the error message
//    @Environment(\.presentationMode) var mode
//    @EnvironmentObject var viewModel: AuthViewModel
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                LinearGradient(gradient: (Gradient(colors: [Color.purple, Color.blue])), startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea()
//                
//                VStack {
//                    ZStack {
//                        // Profile Image Section
//                        if let image = image {
//                            image
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 140, height: 140)
//                                .clipShape(Circle())
//                        } else {
//                            Button(action: { imagePickerPresented.toggle() }, label: {
//                                Image(systemName: "photo.badge.plus")
//                                    .renderingMode(.template)
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 140, height: 140)
//                                    .foregroundColor(.white)
//                            }).sheet(isPresented: $imagePickerPresented, onDismiss: loadImage, content: {
//                                ImagePicker(image: $selectedImage)
//                            })
//                            .padding()
//                        }
//                    }
//                    
//                    VStack(spacing: 20) {
//                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
//                            .padding()
//                            .background(Color(.init(white: 1, alpha: 0.15)))
//                            .cornerRadius(10)
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 32)
//                        
//                        CustomTextField(text: $userName, placeholder: Text("User Name"), imageName: "person")
//                            .padding()
//                            .background(Color(.init(white: 1, alpha: 0.15)))
//                            .cornerRadius(10)
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 32)
//                        
//                        CustomTextField(text: $fullName, placeholder: Text("Full Name"), imageName: "person")
//                            .padding()
//                            .background(Color(.init(white: 1, alpha: 0.15)))
//                            .cornerRadius(10)
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 32)
//                        
//                        CustomSecureField(text: $password, placeholder: Text("Password"), imageName: "lock")
//                            .padding()
//                            .background(Color(.init(white: 1, alpha: 0.15)))
//                            .cornerRadius(10)
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 32)
//                    }
//                    
//                    // Display the error message if it exists
//                    if let errorMessage = errorMessage {
//                        Text(errorMessage)
//                            .foregroundColor(.red)
//                            .font(.subheadline)
//                            .fontWeight(.bold)
//                            .padding(.top, 10)
//                            .padding(.horizontal, 32)
//                    }
//                    
//                    Button(action: {
//                        // Validate inputs before calling the register function
//                        if validateFields() {
//                            viewModel.register(withEmail: email, password: password, image: selectedImage, fullname: fullName, username: userName)
//                        }
//                    }, label: {
//                        Text("Sign Up")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .frame(width: 360, height: 50)
//                            .background(Color.blue)
//                            .clipShape(Capsule())
//                            .padding()
//                    })
//                    
//                    Spacer()
//                    
//                    Button(action: { mode.wrappedValue.dismiss() }, label: {
//                        HStack {
//                            Text("Already have an account?")
//                                .font(.system(size: 14, weight: .semibold))
//                            Text("Login")
//                                .font(.system(size: 14, weight: .semibold))
//                        }.foregroundColor(.white)
//                    })
//                }
//                .padding()
//            }
//            .onAppear {
//                viewModel.errorMessage = nil  // Reset error message when the RegisterPage appears
//            }
//        }
//    }
//    
//    // Image loading function for the profile picture
//    func loadImage() {
//        guard let selectedImage = selectedImage else { return }
//        image = Image(uiImage: selectedImage)
//    }
//    
//    // Validate all the fields to make sure none are empty
//    func validateFields() -> Bool {
//        if email.isEmpty || password.isEmpty || userName.isEmpty || fullName.isEmpty || selectedImage == nil {
//            // Set error message if any field is empty
//            errorMessage = "Please fill in all fields and select a profile image."
//            return false
//        }
//        // Clear any previous error message if all fields are filled
//        errorMessage = nil
//        return true
//    }
//}
//
//#Preview {
//    RegisterPage()
//}
//

import SwiftUI

struct RegisterPage: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var userName = ""
    @State private var fullName = ""
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @State private var imagePickerPresented = false
    @State private var errorMessage: String?  // To store the error message
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: (Gradient(colors: [Color.purple, Color.blue])), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        // Profile Image Section
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                        } else {
                            Button(action: { imagePickerPresented.toggle() }, label: {
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
                    
                    VStack(spacing: 20) {
                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                        
                        CustomTextField(text: $userName, placeholder: Text("User Name"), imageName: "person")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                        
                        CustomTextField(text: $fullName, placeholder: Text("Full Name"), imageName: "person")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                        
                        CustomSecureField(text: $password, placeholder: Text("Password"), imageName: "lock")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                    }
                    
                    // Display the error message if it exists
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                            .padding(.horizontal, 32)
                    }
                    
                    Button(action: {
                        // Validate inputs before calling the register function
                        if validateFields() {
                            viewModel.register(withEmail: email, password: password, image: selectedImage, fullname: fullName, username: userName)
                        }
                    }, label: {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color.blue)
                            .clipShape(Capsule())
                            .padding()
                    })
                    
                    Spacer()
                    
                    Button(action: { mode.wrappedValue.dismiss() }, label: {
                        HStack {
                            Text("Already have an account?")
                                .font(.system(size: 14, weight: .semibold))
                            Text("Login")
                                .font(.system(size: 14, weight: .semibold))
                        }.foregroundColor(.white)
                    })
                }
                .padding()
            }
            .onAppear {
                viewModel.errorMessage = nil  // Reset error message when the RegisterPage appears
            }
        }
    }
    
    // Image loading function for the profile picture
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    // Validate all the fields to make sure none are empty
    func validateFields() -> Bool {
        if email.isEmpty || password.isEmpty || userName.isEmpty || fullName.isEmpty || selectedImage == nil {
            // Set error message if any field is empty
            errorMessage = "Please fill in all fields and select a profile image."
            return false
        }
        
        if password.count < 6 {
            // Set error message if password is too short
            errorMessage = "Password must be at least 6 characters long."
            return false
        }
        
        // Clear any previous error message if all fields are filled and password length is valid
        errorMessage = nil
        return true
    }
}

#Preview {
    RegisterPage()
}
