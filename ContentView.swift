import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var playerWord: String = ""
    @State private var showLogoAnimation = true

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
                    gameManager.handleAttack(from: gameManager.player1, with: playerWord)
                    gameManager.startNewRound()
                    playerWord = ""
                }) {
                    Text("Submit Word")
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
