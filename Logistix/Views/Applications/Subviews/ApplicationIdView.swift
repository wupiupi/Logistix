import SwiftUI

struct ApplicationIdView: View {
    @EnvironmentObject private var applicationsVM: ApplicationsViewModel
    
    let application: Application
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("№ \(applicationsVM.getShortenedID(forApplication: application.id))")
                    .font(.headline)
                    .foregroundStyle(
                        applicationsVM.getStatusColor(
                            forApplicationStatus: application.status
                        ).mainColor
                    )
                    .padding([.top, .bottom], 8)
                    .padding([.leading, .trailing], 8)
                    .background {
                        RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                            .fill(
                                applicationsVM.getStatusColor(
                                    forApplicationStatus: application.status
                                ).backgroundColor
                            )
                    }
                
                Spacer()
                
                Text(applicationsVM.dateFormatter.string(from: application.date))
                    .font(.headline)
            }
        }
    }
}
