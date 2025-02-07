import Foundation

class GameManager: ObservableObject {
    @Published var player1: Player
    @Published var player2: Player
    @Published var currentRound: Int
    @Published var currentLetter: String
    @Published var currentCategory: String
    @Published var player1Score: Int
    @Published var player2Score: Int

    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        self.currentRound = 0
        self.currentLetter = ""
        self.currentCategory = ""
        self.player1Score = 0
        self.player2Score = 0
        print("GameManager initialized with player1: \(player1.name) and player2: \(player2.name)")
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
        if player == player1 {
            player2.health -= score
        } else {
            player1.health -= score
        }
        print("Attack handled from \(player.name) with word \(word). Score: \(score)")
    }

    func attack(with word: String) {
        handleAttack(from: player1, with: word)
        if !isGameOver() {
            let opponentWord = generateRandomWord()
            handleAttack(from: player2, with: opponentWord)
        }
    }

    func isGameOver() -> Bool {
        return player1.health <= 0 || player2.health <= 0
    }

    private func generateRandomLetter() -> String {
        // Implement random letter generation logic here
        return "A"
    }

    private func generateRandomCategory() -> String {
        // Implement random category generation logic here
        return "Animal"
    }

    private func generateRandomWord() -> String {
        // Implement random word generation logic here
        return "example"
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
