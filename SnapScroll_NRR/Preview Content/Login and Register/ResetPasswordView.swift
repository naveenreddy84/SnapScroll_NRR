import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding private var email: String
    @Environment(\.presentationMode) var mode

    init(email: Binding<String>) {
        self._email = email
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: (Gradient(colors: [Color.purple, Color.blue])), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 80) {
                Text("SnapScroll")
                    .font(.custom("HelveticaNeue-Bold", size: 32))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                VStack(spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)

                }
                
                VStack {
                    Button(action: {
                        viewModel.resetPassword(withEmail: email)
                    }, label: {
                        Text("Send Reset Password Link")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 50)
                            .background(Color.blue)
                            .clipShape(Capsule())
                            .padding()
                    })
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(.horizontal, 32)
                    }
                    
                    Button(action: { mode.wrappedValue.dismiss() }, label: {
                        HStack {
                            Text("Already have an account?")
                                .font(.system(size: 14, weight: .semibold))
                            Text("Login")
                                .font(.system(size: 14, weight: .semibold))
                        }.foregroundColor(.white)
                    })
                }
            }
            .onAppear {
                viewModel.errorMessage = nil  // Reset error message when the ResetPasswordView appears
            }
        }
    }
}

#Preview {
    ResetPasswordView(email: .constant(""))
}

