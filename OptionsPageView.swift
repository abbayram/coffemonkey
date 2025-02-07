import SwiftUI

struct OptionsPageView: View {
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

            Spacer()

            Button(action: {
                // Action for playing online with random people
            }) {
                Text("Play Online with Random People")
                    .font(.title)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                // Action for playing with friends
            }) {
                Text("Play Friends")
                    .font(.title)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
    }
}

struct OptionsPageView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsPageView()
    }
}
