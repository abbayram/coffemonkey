import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var player1Word: String = ""
    @State private var player2Word: String = ""
    @State private var showLogoAnimation = true

    var body: some View {
        VStack {
            if showLogoAnimation {
                LogoAnimationView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showLogoAnimation = false
                        }
                    }
            } else {
                Text("Round \(gameManager.currentRound)")
                    .font(.largeTitle)
                    .padding()

                Text("Letter: \(gameManager.currentLetter)")
                    .font(.title)
                    .padding()

                Text("Category: \(gameManager.currentCategory)")
                    .font(.title)
                    .padding()

                HStack {
                    VStack {
                        Text("Player 1")
                            .font(.headline)
                        TextField("Enter word", text: $player1Word)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Text("Score: \(gameManager.player1Score)")
                        Text("Health: \(gameManager.player1.health)")
                    }
                    .padding()

                    VStack {
                        Text("Player 2")
                            .font(.headline)
                        TextField("Enter word", text: $player2Word)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Text("Score: \(gameManager.player2Score)")
                        Text("Health: \(gameManager.player2.health)")
                    }
                    .padding()
                }

                Button(action: {
                    gameManager.handleAttack(from: gameManager.player1, with: player1Word)
                    gameManager.handleAttack(from: gameManager.player2, with: player2Word)
                    gameManager.startNewRound()
                    player1Word = ""
                    player2Word = ""
                }) {
                    Text("Submit Words")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .onAppear {
            print("ContentView appeared")
        }
        .onChange(of: gameManager.currentRound) { newValue in
            print("Current round changed to \(newValue)")
        }
        .onChange(of: gameManager.currentLetter) { newValue in
            print("Current letter changed to \(newValue)")
        }
        .onChange(of: gameManager.currentCategory) { newValue in
            print("Current category changed to \(newValue)")
        }
    }
}
