import SwiftUI

struct StartPageView: View {
    @State private var player1Name: String = ""
    @State private var player2Name: String = ""
    @State private var isConnected: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack {
            Text("Welcome to Word Wars")
                .font(.largeTitle)
                .padding()

            TextField("Player 1 Name", text: $player1Name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Player 2 Name", text: $player2Name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                connectPlayers()
            }) {
                Text("Connect Players")
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
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func connectPlayers() {
        let player1 = Player(name: player1Name)
        let player2 = Player(name: player2Name)
        FirebaseManager.shared.connectPlayers(player1: player1, player2: player2) { success in
            if success {
                isConnected = true
            } else {
                alertMessage = "Failed to connect players. Please try again."
                showAlert = true
            }
        }
    }

    private func startGame() {
        NotificationCenter.default.post(name: NSNotification.Name("GameStarted"), object: nil)
    }
}

struct StartPageView_Previews: PreviewProvider {
    static var previews: some View {
        StartPageView()
    }
}
