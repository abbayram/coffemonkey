import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(.gray)

                Rectangle()
                    .frame(width: min(CGFloat(self.progress) / 100.0 * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(.green)
            }
            .cornerRadius(45.0)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: .constant(50))
    }
}
