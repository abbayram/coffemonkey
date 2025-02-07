import Foundation
import Firebase
import FirebaseAuth

class FirebaseManager {
    static let shared = FirebaseManager()
    private var db = Firestore.firestore()
    private var gameSessionId: String?
    private var isPlayerRegistered: Bool = false

    private init() {}

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

    func connectPlayer(player: Player, completion: @escaping (Bool) -> Void) {
        let playerData: [String: Any] = [
            "name": player.name,
            "health": player.health
        ]

        db.collection("players").document(player.id.uuidString).setData(playerData) { error in
            if let error = error {
                print("Error connecting player: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
