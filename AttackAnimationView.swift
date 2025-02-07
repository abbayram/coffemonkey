import SwiftUI

struct AttackAnimationView: View {
    @Binding var isAttacking: Bool
    @Binding var player1Health: Int
    @Binding var player2Health: Int

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
            }

            HStack {
                VStack {
                    Text("Player 1 Health")
                    ProgressBar(value: $player1Health)
                }
                VStack {
                    Text("Player 2 Health")
                    ProgressBar(value: $player2Health)
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
        }
        .onChange(of: player2Health) { newValue in
            print("player2Health changed to \(newValue)")
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

struct AttackAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AttackAnimationView(isAttacking: .constant(true), player1Health: .constant(100), player2Health: .constant(100))
    }
}
