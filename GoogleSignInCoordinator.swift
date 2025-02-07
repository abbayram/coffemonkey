import GoogleSignIn

class GoogleSignInCoordinator: NSObject, GIDSignInDelegate {
    
    func startSignInWithGoogleFlow() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let signInConfig = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: UIApplication.shared.windows.first { $0.isKeyWindow }!) { user, error in
            if let error = error {
                print("Sign in with Google errored: \(error.localizedDescription)")
                return
            }
            
            guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign in with Google errored: \(error.localizedDescription)")
                    return
                }
                
                guard let user = authResult?.user else { return }
                
                let user = User(uid: user.uid, email: user.email, displayName: user.displayName)
                FirebaseManager.shared.handleAuthenticatedUser(user: user) { success in
                    if success {
                        print("User successfully authenticated and stored in Firebase")
                    } else {
                        print("Failed to store user in Firebase")
                    }
                }
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Sign in with Google errored: \(error.localizedDescription)")
            return
        }
        
        guard let authentication = user.authentication, let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Firebase sign in with Google errored: \(error.localizedDescription)")
                return
            }
            
            guard let user = authResult?.user else { return }
            
            let user = User(uid: user.uid, email: user.email, displayName: user.displayName)
            FirebaseManager.shared.handleAuthenticatedUser(user: user) { success in
                if success {
                    print("User successfully authenticated and stored in Firebase")
                } else {
                    print("Failed to store user in Firebase")
                }
            }
        }
    }
}
