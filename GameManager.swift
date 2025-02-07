import Foundation

class GameManager: ObservableObject {
    @Published var player1: Player
    @Published var currentRound: Int
    @Published var currentLetter: String
    @Published var currentCategory: String
    @Published var player1Score: Int

    init(player1: Player) {
        self.player1 = player1
        self.currentRound = 0
        self.currentLetter = ""
        self.currentCategory = ""
        self.player1Score = 0
        print("GameManager initialized with player1: \(player1.name)")
    }

    func startNewRound() {
        currentRound += 1
        currentLetter = generateRandomLetter()
        currentCategory = generateRandomCategory()
        print("New round started: \(currentRound), Letter: \(currentLetter), Category: \(currentCategory)")
    }

    func calculateScore(for word: String) -> Int {
        // Implement word validation and scoring logic here
        return 0
    }

    func handleAttack(from player: Player, with word: String) {
        let score = calculateScore(for: word)
        player1Score -= score
        print("Attack handled from \(player.name) with word \(word). Score: \(score)")
    }

    private func generateRandomLetter() -> String {
        // Implement random letter generation logic here
        return "A"
    }

    private func generateRandomCategory() -> String {
        // Implement random category generation logic here
        return "Animal"
    }
}

class Player: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var health: Int

    init(name: String, health: Int = 100) {
        self.name = name
        self.health = health
        print("Player initialized with name: \(name), health: \(health)")
    }

    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}
