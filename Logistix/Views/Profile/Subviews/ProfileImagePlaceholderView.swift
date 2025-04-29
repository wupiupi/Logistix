import SwiftUI

struct ProfileImagePlaceholderView: View {
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: "camera.fill")
                .font(.system(size: 20))
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 100)
        .background(Color.gray.opacity(0.1))
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}
