import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var playerWord: String = ""
    @State private var isGameOver: Bool = false

    var body: some View {
        VStack {
            Text("Round \(gameManager.currentRound)")
                .font(.largeTitle)
                .padding()

            Text("Letter: \(gameManager.currentLetter)")
                .font(.title)
                .padding()

            Text("Category: \(gameManager.currentCategory)")
                .font(.title)
                .padding()

            VStack {
                Text("Player")
                    .font(.headline)
                TextField("Enter word", text: $playerWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Text("Score: \(gameManager.player1Score)")
                Text("Health: \(gameManager.player1.health)")
            }
            .padding()

            Button(action: {
                gameManager.attack(with: playerWord)
                playerWord = ""
                if gameManager.isGameOver() {
                    isGameOver = true
                }
            }) {
                Text("Submit Word")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            HStack {
                VStack {
                    Text("Player 1 Health")
                    ProgressBar(value: $gameManager.player1.health)
                }
                VStack {
                    Text("Player 2 Health")
                    ProgressBar(value: $gameManager.player2.health)
                }
            }
            .padding()
        }
        .alert(isPresented: $isGameOver) {
            Alert(
                title: Text("Game Over"),
                message: Text("Would you like to play again or return to the main menu?"),
                primaryButton: .default(Text("Play Again")) {
                    gameManager.startNewRound()
                    isGameOver = false
                },
                secondaryButton: .cancel(Text("Main Menu")) {
                    // Navigate to main menu
                }
            )
        }
        .onAppear {
            gameManager.startNewRound()
        }
    }
}

struct ProgressBar: View {
    @Binding var value: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(.gray)

                Rectangle()
                    .frame(width: min(CGFloat(self.value) / 100.0 * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(.green)
            }
            .cornerRadius(45.0)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(GameManager(player1: Player(name: "Player 1")))
    }
}
