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
                        .animation(.easeInOut(duration: 0.5))
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
                    .animation(.linear)
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
