import SwiftUI

struct AttackAnimationView: View {
    @Binding var isAttacking: Bool
    @Binding var player1Health: Int
    @Binding var player2Health: Int
    @State private var showGameOverAlert: Bool = false

    var body: some View {
        ZStack {
            if isAttacking {
                VStack {
                    Text("Attack!")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .transition(.scale)
                    Spacer()
                }
                .animation(.easeInOut(duration: 0.5))
            }

            HStack {
                VStack {
                    Text("Player 1 Health")
                    ProgressBar(progress: $player1Health)
                }
                VStack {
                    Text("Player 2 Health")
                    ProgressBar(progress: $player2Health)
                }
            }
        }
        .onAppear {
            print("AttackAnimationView appeared")
        }
        .onChange(of: isAttacking) { newValue in
            print("isAttacking changed to \(newValue)")
        }
        .onChange(of: player1Health) { newValue in
            print("player1Health changed to \(newValue)")
            if player1Health <= 0 {
                showGameOverAlert = true
            }
        }
        .onChange(of: player2Health) { newValue in
            print("player2Health changed to \(newValue)")
            if player2Health <= 0 {
                showGameOverAlert = true
            }
        }
        .alert(isPresented: $showGameOverAlert) {
            Alert(
                title: Text("Game Over"),
                message: Text("Would you like to play again or return to the main menu?"),
                primaryButton: .default(Text("Play Again")) {
                    // Implement play again action
                },
                secondaryButton: .cancel(Text("Main Menu")) {
                    // Implement return to main menu action
                }
            )
        }
    }
}

struct AttackAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AttackAnimationView(isAttacking: .constant(true), player1Health: .constant(100), player2Health: .constant(100))
    }
}
