import SwiftUI
import Firebase

@main
struct WordWarsApp: App {
    @StateObject private var gameManager = GameManager(player1: Player(name: "Player 1"), player2: Player(name: "Player 2"))
    @State private var isGameStarted = false

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if isGameStarted {
                ContentView()
                    .environmentObject(gameManager)
            } else {
                StartPageView()
                    .onAppear {
                        NotificationCenter.default.addObserver(forName: NSNotification.Name("GameStarted"), object: nil, queue: .main) { _ in
                            isGameStarted = true
                        }
                    }
            }
        }
    }
}
