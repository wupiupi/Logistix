import SwiftUI

struct HeaderNewOrderView: View {
    var body: some View {
        HStack {
            Text("Оформление доставки")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
            
            Spacer()
            
            Image("bricks")
                .resizable()
                .frame(width: 83, height: 65)
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}

