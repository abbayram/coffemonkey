import Foundation
import Firebase
import FirebaseAuth

class FirebaseManager {
    static let shared = FirebaseManager()
    private var db = Firestore.firestore()
    private var gameSessionId: String?
    private var isPlayerRegistered: Bool = false

    private init() {}

    func connectPlayers(player1: Player, player2: Player, completion: @escaping (Bool) -> Void) {
        let gameSession = db.collection("gameSessions").document()
        gameSessionId = gameSession.documentID
        let data: [String: Any] = [
            "player1": player1.name,
            "player2": player2.name,
            "player1Health": player1.health,
            "player2Health": player2.health,
            "currentRound": 0,
            "currentLetter": "",
            "currentCategory": ""
        ]
        gameSession.setData(data) { error in
            if let error = error {
                print("Error creating game session: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func updateGameState(gameSessionId: String, gameState: [String: Any], completion: @escaping (Bool) -> Void) {
        let gameSession = db.collection("gameSessions").document(gameSessionId)
        gameSession.updateData(gameState) { error in
            if let error = error {
                print("Error updating game state: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

    func listenForGameStateChanges(gameSessionId: String, completion: @escaping ([String: Any]?) -> Void) {
        let gameSession = db.collection("gameSessions").document(gameSessionId)
        gameSession.addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching game state: \(error!)")
                completion(nil)
                return
            }
            completion(document.data())
        }
    }

    func arePlayersConnected() -> Bool {
        return gameSessionId != nil
    }

    func handleAuthenticatedUser(user: User, completion: @escaping (Bool) -> Void) {
        guard !isPlayerRegistered else {
            completion(false)
            return
        }

        let userData: [String: Any] = [
            "uid": user.uid,
            "email": user.email ?? "",
            "displayName": user.displayName ?? ""
        ]

        db.collection("users").document(user.uid).setData(userData) { error in
            if let error = error {
                print("Error storing user data: \(error)")
                completion(false)
            } else {
                self.isPlayerRegistered = true
                completion(true)
            }
        }
    }
}
