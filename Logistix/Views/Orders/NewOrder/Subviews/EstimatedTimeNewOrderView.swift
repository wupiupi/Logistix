import SwiftUI

struct EstimatedTimeNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Расчетное время")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.text)
            
            Text("Дата погрузки")
                .font(.headline)
                .foregroundStyle(.gray)
            
            CustomDatePickerView(date: $newOrderVM.dateOfLoading)
            
            Text("Дата доставки")
                .font(.headline)
                .foregroundStyle(.gray)
            
            CustomDatePickerView(date: $newOrderVM.dateOfDelivery)
        }
        .padding(.leading)
    }
}
