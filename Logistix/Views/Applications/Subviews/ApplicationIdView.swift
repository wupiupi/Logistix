import SwiftUI

struct ApplicationIdView: View {
    @EnvironmentObject private var applicationsVM: ApplicationsViewModel
    
    let application: Application
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("№ \(application.id)")
                    .font(.title3)
                    .foregroundStyle(
                        applicationsVM.getStatusColor(
                            forApplicationStatus: application.status
                        ).mainColor
                    )
                    .padding([.top, .bottom], 8)
                    .padding([.leading, .trailing], 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                applicationsVM.getStatusColor(
                                    forApplicationStatus: application.status
                                ).backgroundColor
                            )
                    }
                
                Spacer()
                
                Text(applicationsVM.dateFormatter.string(from: application.date))
                    .font(.title3)
            }
        }
    }
}
