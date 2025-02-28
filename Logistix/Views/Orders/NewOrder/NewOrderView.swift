import SwiftUI

struct NewOrderView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // MARK: - Header
                    HeaderNewOrderView()
                    Divider()
                    
                    // MARK: - Route
                    RouteNewOrderView()
                    Divider()
                    
                    // MARK: - Contact info
                    ContactNewOrderView()
                    Divider()
                    
                    // MARK: - Carrier info
                    CarrierNewOrderView()
                    Divider()
                    
                    // MARK: - Estimated time
                    EstimatedTimeNewOrderView()
                    Divider()
                    
                    // MARK: - Image Picker
                    SelectImageView()
                    Divider()
                    
                    // MARK: - Worth of order
                    WorthNewOrderView()
                    Divider()
                    
                    // MARK: - Payment method
                    PaymentMethodNewOrderView()
                    Divider()
                    
                    // MARK: - In total
                    InTotalNewOrderView()
                    
                    // MARK: - Create order button
                    CreateNewOrderButtonView()
                }
                .navigationTitle("Logistix")
            }
        }
    }
}
