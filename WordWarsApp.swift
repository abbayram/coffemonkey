import SwiftUI
import Firebase

@main
struct WordWarsApp: App {
    @StateObject private var gameManager = GameManager(player1: Player(name: "Player 1"), player2: Player(name: "Player 2"))

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameManager)
        }
    }
}
