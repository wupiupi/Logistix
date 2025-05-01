import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var profileVM: UserProfileViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 14) {
                ProfileUserImageView()
                
                editableField(
                    title: "Имя",
                    value: profileVM.displayedName,
                    fieldKey: "name",
                    showAlert: $profileVM.showNameAlert,
                    isSecure: false
                )
                
                editableField(
                    title: "Пароль",
                    value: "********",
                    fieldKey: "pass",
                    showAlert: $profileVM.showPassAlert,
                    isSecure: true
                )

                Spacer()
            }
            .padding()
            .hAlign(.center)
            .navigationTitle("Профиль")
            .alert(profileVM.alertMessage, isPresented: $profileVM.showResultAlert) {
                Button("Ок", role: .cancel) {}
            }
        }
        .onAppear {
            profileVM.displayedName = authVM.currentUser?.name ?? ""
        }
    }

    @ViewBuilder
    private func editableField(
        title: String,
        value: String,
        fieldKey: String,
        showAlert: Binding<Bool>,
        isSecure: Bool
    ) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(value)
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            Button {
                profileVM.newValue = ""
                profileVM.confirmPassword = ""
                showAlert.wrappedValue = true
            } label: {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
        }
        .alert("Изменить \(title)", isPresented: showAlert) {
            if isSecure {
                SecureField("Новый пароль", text: $profileVM.newValue)
                SecureField("Повторите пароль", text: $profileVM.confirmPassword)
            } else {
                TextField("Новое имя", text: $profileVM.newValue)
            }

            Button("Сохранить") {
                Task {
                    await profileVM.updateField(fieldKey: fieldKey, newValue: profileVM.newValue)
                    await authVM.fetchUser()
                }
            }
            Button("Отмена", role: .cancel) {}
        } message: {
            Text(isSecure ? "Введите и подтвердите новый пароль" : "Введите новое имя")
        }
    }

}
