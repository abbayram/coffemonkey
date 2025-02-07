import SwiftUI

struct LogoAnimationView: View {
    @State private var isAnimating = false

    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .opacity(isAnimating ? 1 : 0)
            .scaleEffect(isAnimating ? 1 : 0.5)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    isAnimating = true
                }
            }
    }
}

struct LogoAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LogoAnimationView()
    }
}
