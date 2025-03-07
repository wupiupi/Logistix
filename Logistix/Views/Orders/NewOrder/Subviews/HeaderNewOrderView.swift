import SwiftUI

struct HeaderNewOrderView: View {
    var body: some View {
        HStack {
            Text("Оформление доставки")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.text)
            
            Spacer()
            
            Image("bricks")
                .resizable()
                .frame(width: 83, height: 65)
        }
        .padding(.horizontal)
    }
}

