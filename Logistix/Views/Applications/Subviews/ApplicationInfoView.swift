import SwiftUI

struct ApplicationInfoView: View {
    @EnvironmentObject private var applicationsVM: ApplicationsViewModel
    
    let application: Application
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("№ \(application.id)")
                .modifier(
                    TitleModifier(
                        font: .title,
                        fontWeight: .bold,
                        color: .expandableViewMain
                    )
                )
            
            OrderDetailsView(
                title: "Имя контакта",
                orderInfo: application.name
            )
            OrderDetailsView(
                title: "Электронная почта",
                orderInfo: application.email
            )
            OrderDetailsView(
                title: "Компания",
                orderInfo: application.company
            )
            OrderDetailsView(
                title: "Контактный телефон",
                orderInfo: application.phone
            )
            OrderDetailsView(
                title: "Создано поользователем c UID:",
                orderInfo: application.userID
            )
            
            Text("Статус")
                .font(.title3)
                .foregroundStyle(.gray)
            
            Text(application.status)
                .font(.title3)
                .foregroundStyle(
                    Color(
                        applicationsVM.getStatusColor(
                            forApplicationStatus: application.status
                        ).mainColor
                    )
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
            
            switch application.status {
                case ApplicationStatus.waitingForAnswer.rawValue:
                    OrderButtonView(
                        title: "Отметить как выполненное",
                        titleColor: .statusGreen,
                        backColor: .statusGreenBackground) {
                            Task {
                                await applicationsVM.updateApplicationStatus(
                                    forID: application.id,
                                    status: ApplicationStatus.completed.rawValue
                                )
                            }
                        }
                default:
                    OrderButtonView(
                        title: "Удалить",
                        titleColor: .red,
                        backColor: .clear) {
                            Task {
                                await applicationsVM.deleteApplication(withID: application.id)
                            }
                        }
            }
        }
        .padding()
        .hAlign(.center)
    }
}
