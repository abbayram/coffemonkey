import Foundation

class WordValidation {
    private let validWords: Set<String>

    init(validWords: Set<String>) {
        self.validWords = validWords
    }

    func validate(word: String) -> Bool {
        return validWords.contains(word.lowercased())
    }

    func calculateRarityScore(for word: String) -> Int {
        // Implement rarity-based scoring logic here
        // For now, return a placeholder value
        return 1
    }
}
