import SwiftUI
import Firebase
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage: String?  // Property to store the error message
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                // Capture and set the error message if login fails
                self.errorMessage = "Invalid username/password. Please try again."
                print("DEBUG: Login Failed \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            
            // Reset error message after successful login
            self.errorMessage = nil
        }
    }
    
    func register(withEmail email: String, password: String,
                  image: UIImage?, fullname: String, username: String) {
        guard let image = image else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    self.errorMessage = "Error registering: \(error.localizedDescription)"
                    print("DEBUG: Registration Failed \(error.localizedDescription)")
                    return
                }
                
                guard let user = result?.user else { return }
                print("Successfully registered user!")
                
                let data = ["email": email,
                            "username": username,
                            "fullname": fullname,
                            "profileImageUrl": imageUrl,
                            "uid": user.uid]
                
                COLLECTIONS_USERS.document(user.uid).setData(data) { _ in
                    print("Successfully uploaded user data to Firestore!")
                    self.userSession = user
                    self.fetchUser()
                    
                    // Reset error message after successful registration
                    self.errorMessage = nil
                }
            }
        }
    }
    
    func signout() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword(withEmail email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                self.errorMessage = error.localizedDescription
                print("error reset password: \(error.localizedDescription)")
            } else {
                self.errorMessage = "A password reset link has been sent to your email."
            }
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTIONS_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
}

