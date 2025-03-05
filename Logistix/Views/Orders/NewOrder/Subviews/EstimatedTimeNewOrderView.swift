import SwiftUI

struct EstimatedTimeNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Расчетное время")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.text)
            
            Text("Дата погрузки")
                .foregroundStyle(.text)
                .font(.title3)
            
            CustomDatePickerView(date: $newOrderVM.dateOfLoading)
            
            Text("Дата доставки")
                .foregroundStyle(.text)
                .font(.title3)
            
            CustomDatePickerView(date: $newOrderVM.dateOfDelivery)
        }
        .padding(.leading)
    }
}
