import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var showLogoAnimation = true
    @State private var isGameStarted = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Profile settings action
                }) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.leading)

                Spacer()

                Button(action: {
                    // Other necessary settings action
                }) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.trailing)
            }
            .padding(.top)

            if showLogoAnimation {
                LogoAnimationView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            showLogoAnimation = false
                        }
                    }
            } else {
                if isGameStarted {
                    NavigationView {
                        GameView()
                            .environmentObject(gameManager)
                    }
                } else {
                    Button(action: {
                        isGameStarted = true
                    }) {
                        Text("Start Game")
                            .font(.title)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            print("ContentView appeared")
        }
        .onChange(of: gameManager.currentRound) { newValue in
            print("Current round changed to \(newValue)")
        }
        .onChange(of: gameManager.currentLetter) { newValue in
            print("Current letter changed to \(newValue)")
        }
        .onChange(of: gameManager.currentCategory) { newValue in
            print("Current category changed to \(newValue)")
        }
    }
}
