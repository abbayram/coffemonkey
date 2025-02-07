import SwiftUI
import AuthenticationServices

struct StartPageView: View {
    @State private var playerName: String = ""
    @State private var isConnected: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Profile settings action
                }) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.leading)

                Spacer()

                Button(action: {
                    // Other necessary settings action
                }) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.trailing)
            }
            .padding(.top)

            Text("Welcome to Word Wars")
                .font(.largeTitle)
                .padding()

            TextField("Player Name", text: $playerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                connectPlayer()
            }) {
                Text("Next")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(isConnected)

            if isConnected {
                Button(action: {
                    startGame()
                }) {
                    Text("Start Game")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }

            // Apple ID Sign-In Button
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        handleAppleSignIn(authorization: authorization)
                    case .failure(let error):
                        alertMessage = "Apple Sign-In failed: \(error.localizedDescription)"
                        showAlert = true
                    }
                }
            )
            .signInWithAppleButtonStyle(.black)
            .frame(width: 280, height: 45)
            .padding()

            // New buttons for playing online with random people and playing with friends
            Button(action: {
                // Action for playing online with random people
            }) {
                Text("Play Online with Random People")
                    .font(.title)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                // Action for playing with friends
            }) {
                Text("Play Friends")
                    .font(.title)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func connectPlayer() {
        let player = Player(name: playerName)
        FirebaseManager.shared.connectPlayer(player: player) { success in
            if success {
                isConnected = true
            } else {
                alertMessage = "Failed to connect player. Please try again."
                showAlert = true
            }
        }
    }

    private func startGame() {
        NotificationCenter.default.post(name: NSNotification.Name("GameStarted"), object: nil)
    }

    private func handleAppleSignIn(authorization: ASAuthorization) {
        // Navigate to the new options page after successful sign-in
        // This is a placeholder for the actual navigation logic
        print("Apple Sign-In successful. Navigate to options page.")
    }
}
