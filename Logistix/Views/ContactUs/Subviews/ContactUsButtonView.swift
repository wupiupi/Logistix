import SwiftUI

struct ContactUsButtonView: View {
    @EnvironmentObject private var contactUsVM: ContactUsViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        Button {
            let application = Application(
                id: UUID().uuidString,
                userID: authVM.currentUser?.id ?? "",
                name: contactUsVM.name,
                email: contactUsVM.email,
                company: contactUsVM.company,
                phone: contactUsVM.phone,
                status: ApplicationStatus.waitingForAnswer.rawValue,
                date: Date()
            )
            Task {
                await authVM.addApplicationToUser(application: application)
            }
            
            contactUsVM.isShowingAlert = true
        } label: {
            Text("Отправить")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.semibold)
                .frame(
                    width: UIScreen.main.bounds.width - 70,
                    height: 50
                )
                .background {
                    Capsule()
                        .fill(Color(hex: 0x00CCA6, alpha: 1))
                }
        }
        .alert(
            "Готово",
            isPresented: $contactUsVM.isShowingAlert,
            actions: {
                Button("OK") {
                    contactUsVM.name = ""
                    contactUsVM.email = ""
                    contactUsVM.company = ""
                    contactUsVM.phone = ""
                }
            },
            message: {
                Text("Наши специалисты свяжутся с Вами в самое ближайшее время!")
            }
        )
        .disabled(!contactUsVM.formIsValid)
        .opacity(contactUsVM.formIsValid ? 1.0 : 0.5)
    }
}
