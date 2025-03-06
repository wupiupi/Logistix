import SwiftUI

struct CarrierView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Для перевозчиков")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            CarrierInfoView(
                text: "Все поставщики на одной платформе – забирайте самые выгодные заказы"
            )
            
            CarrierInfoView(
                text: "Только выгодные рейсы – наши пользователи зарабатывают более 7 000 белорусских рублей в год"
            )
            
            CarrierInfoView(
                text: "Гарантия загрузки – за ложные заказы предусмотрены штрафы"
            )
            
            CarrierButtonView()
                .padding(.top, 10)
        }
        .padding([.leading, .trailing], 8)
        .padding(.vertical, 35)
        .background {
            Rectangle()
                .fill(.carrierBlue)
                .padding([.leading, .trailing], -8)
        }
        .padding(.bottom, -10)
    }
}
