//
//  NewOrderView.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import SwiftUI
import RealmSwift

struct NewOrderView: View {
    @ObservedResults(Order.self) var orders
    @EnvironmentObject private var viewModel: AuthViewModel
    
    // MARK: - Payment
    enum Payment: String, CaseIterable {
        case card = "Картой онлайн"
        case cache = "Наличными"
    }
    
    // MARK: - Weight
    enum Weight: String, CaseIterable {
        case belowOneHundred = "до 100 кг"
        case belowFourHundred = "до 400 кг"
        case overFourHundred = "свыше 400 кг"
    }
    
    // MARK: - State Properties
    @State private var sourceAddress = ""
    @State private var destinationAddress = ""
    @State private var senderName = ""
    @State private var senderPhoneNumber = ""
    @State private var recipientName = ""
    @State private var recipientPhoneNumber = ""
    @State private var selectedWeight: Weight = .belowOneHundred
    @State private var dateOfLoading: Date?
    @State private var dateOfDelivery: Date?
    @State private var cargoCost = ""
    @State private var payment: Payment = .cache
    
    @State private var isAgreededPrivacy = false
    @State private var isShowingAlert = false
    
    // MARK: - Computable Properties
    private var totalCost: String {
        switch selectedWeight {
        case .belowOneHundred: "5.000"
        case .belowFourHundred: "7.500"
        case .overFourHundred: "10.000"
        }
    }
    
    // MARK: - Init
    init(
        sourceAddress: String = "",
        destinationAddress: String = "",
        senderName: String = "",
        senderPhoneNumber: String = "",
        recipientName: String = "",
        recipientPhoneNumber: String = "",
        selectedWeight: Weight
    ) {
        self.sourceAddress = sourceAddress
        self.destinationAddress = destinationAddress
        self.senderName = senderName
        self.senderPhoneNumber = senderPhoneNumber
        self.recipientName = recipientName
        self.recipientPhoneNumber = recipientPhoneNumber
        self.selectedWeight = selectedWeight
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .main
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.backgroundGray],
            for: .normal
        )
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Оформление доставки")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                        
                        Spacer()
                        
                        Image("bricks")
                            .resizable()
                            .frame(width: 83, height: 65)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 90)
                    
                    Divider()
                    
                    // MARK: - МАРШРУТ
                    VStack(alignment: .leading) {
                        Text("Маршрут")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                            .padding(.leading)
                        
                        VStack {
                            InputView(
                                text: $sourceAddress,
                                title: "Откуда:",
                                placeholder: "Адрес отправки"
                            )
                            
                            InputView(
                                text: $destinationAddress,
                                title: "Куда:",
                                placeholder: "Адрес доставки"
                            )
                        }
                        .hAlign(.center)
                    }
                    .padding(.bottom, 50)
                    
                    Divider()
                    
                    // MARK: - КОНТАКТНЫЕ ДАННЫЕ
                    VStack(alignment: .leading) {
                        Text("Контактные данные")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                            .padding(.leading)
                        
                        // TODO: - Insert Name of Current User as Placeholder
                        VStack {
                            InputView(
                                text: $senderName,
                                title: "Отправитель:",
                                placeholder: "Иванов Иван Иванович"
                            )
                            
                            InputView(
                                text: $senderPhoneNumber,
                                title: "Телефон:",
                                placeholder: "+375(XX)XXX-XX-XX"
                            )
                            
                            InputView(
                                text: $recipientName,
                                title: "Получатель:",
                                placeholder: "Иванов Иван Иванович"
                            )
                            
                            InputView(
                                text: $recipientPhoneNumber,
                                title: "Телефон:",
                                placeholder: "+375(XX)XXX-XX-XX"
                            )
                        }
                        .hAlign(.center)
                    }
                    .padding(.bottom, 20)
                    
                    // MARK: - ЧТО ВЕЗЁМ
                    VStack(alignment: .leading, spacing: 20) {
                        VStack {
                            Text("Что везем")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                                .padding(.leading)
                            
                            Text("Тип вложения")
                                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                                .font(.title3)
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Скоропортящиеся продукты")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(
                                    width: UIScreen.main.bounds.width - 32,
                                    height: 50
                                )
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(hex: 0x00CCA6, alpha: 1))
                                }
                        }
                        .hAlign(.center)
                        
                        Text("Вес:")
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                            .font(.title3)
                            .padding(.leading)
                        
                        Picker("", selection: $selectedWeight) {
                            ForEach(Weight.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.bottom, 20)
                    
                    Divider()
                    
                    // MARK: - РАСЧЕТНОЕ ВРЕМЯ
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Расчетное время")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                        
                        Text("Дата погрузки")
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                            .font(.title3)
                        
                        CustomDatePicker(date: $dateOfLoading)
                        
                        Text("Дата доставки")
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                            .font(.title3)
                        
                        CustomDatePicker(date: $dateOfDelivery)
                    }
                    .padding(.leading)
                    
                    Divider()
                    
                    // MARK: - ЦЕННОСТЬ ГРУЗА
                    VStack(alignment: .leading) {
                        Text("Ценность груза")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                        
                        InputView(
                            text: $cargoCost,
                            title: "",
                            placeholder: "Ценность груза",
                            isNumPad: true
                        )
                        
                        Text("Компенсируем ценность поврежденного груза в течении трех рабочих дней. Максимальная компенсация – 3000 BYN")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.backgroundGray)
                    }
                    .hAlign(.center)
                    .padding(.bottom, 20)
                    
                    Divider()
                    
                    // MARK: - СПОСОБ ОПЛАТЫ
                    VStack(alignment: .leading) {
                        Text("Способ оплаты")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                            .padding(.leading)
                        
                        Text("Выберите способ оплаты:")
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                            .font(.title3)
                            .padding(.leading)
                        
                        Picker("", selection: $payment) {
                            ForEach(Payment.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.bottom, 20)
                    
                    Divider()
                    
                    // MARK: - ИТОГО
                    VStack(alignment: .center) {
                        Text("Итого:")
                            .font(.title3)
                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                        
                        
                        Text("\(totalCost) BYN")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .frame(width: UIScreen.main.bounds.width - 42)
                    .padding(.vertical, 40)
                    .background {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.white)
                            .shadow(radius: 10)
                    }
                    .hAlign(.center)
                    
                    VStack {
                        Toggle(isOn: $isAgreededPrivacy) {
                            VStack {
                                Text("Согласен(-на) на обработку")
                                    .font(.subheadline)
                                    .foregroundStyle(.backgroundGray)
                                Text("персональных данных согласно")
                                    .font(.subheadline)
                                    .foregroundStyle(.backgroundGray)
                                Button {
                                    
                                } label: {
                                    Text("политике конфиденциальности")
                                        .font(.subheadline)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .toggleStyle(CheckboxToggleStyle())
                    }
                    .hAlign(.center)
                    .padding(.bottom, 20)
                    
                    Button {
                        let order = Order()
                        let route = Route()
                        let sender = Sender()
                        let recipient = Recipient()
                        let price = Price()
                                    
                        order.userID = viewModel.currentUser?.id ?? ""
                        order.trackingNumber = .generateTrackNum()
                        
                        /// - Route Implementation
                        route.sourceAddress = sourceAddress
                        route.destinationAddress = destinationAddress
                        order.route = route
                        
                        /// - Sender Implementation
                        sender.name = senderName
                        sender.phoneNumber = senderPhoneNumber
                        order.sender = sender
                        
                        /// - Recipient Implementation
                        recipient.name = recipientName
                        recipient.phoneNumber = recipientPhoneNumber
                        order.recipient = recipient
                        
                        // ? Не работает ?
//                        order.recipient?.name = recipientName
//                        order.recipient?.phoneNumber = recipientPhoneNumber
                        
                        order.cargoType = ""
                        order.weight = selectedWeight.rawValue
                        order.dateOfLoading = dateOfLoading ?? Date()
                        order.dateOfDelivery = dateOfDelivery ?? Date()
                        
                        /// - Cargo
                        price.payment = payment.rawValue
                        price.cargoCost = cargoCost
                        price.totalCost = totalCost
                        order.price = price
                        
//                        order.cargoCost = cargoCost
//                        order.payment = payment.rawValue
//                        order.totalCost = totalCost
                        
                        $orders.append(order)
                        
                        isShowingAlert = true
                    } label: {
                        HStack {
                            Text("Отправить заявку")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                        .padding([.leading, .trailing], 16)
                        .foregroundStyle(.white)
                    }
                    .background {
                        Capsule()
                            .fill(Color(hex: 0x00CCA6, alpha: 1))
                    }
                    .hAlign(.center)
                    .disabled(!isAgreededPrivacy)
                    .opacity(isAgreededPrivacy ? 1 : 0.3)
                    .alert(
                        "Готово",
                        isPresented: $isShowingAlert,
                        actions: {
                            Button("OK") {
                                sourceAddress = ""
                                destinationAddress = ""
                                senderName = ""
                                senderPhoneNumber = ""
                                recipientName = ""
                                recipientPhoneNumber = ""
                                cargoCost = ""
                                isAgreededPrivacy = false
                            }
                        },
                        message: {
                            Text("Ваша заявка успешно зарегистрирована")
                        }
                    )
                }
                .navigationTitle("Logistix")
            }
        }
    }
    
    
    @ViewBuilder
    func CustomDatePicker(date: Binding<Date?>) -> some View {
        DatePickerTextField(
            placeholder: "Выберите дату",
            date: date
        )
        .font(.title)
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width - 32, height: 46)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .foregroundStyle(Color.main)
                }
        }
    }
}

#Preview {
    NewOrderView(selectedWeight: .belowOneHundred)
}

// MARK: - CheckboxToggleStyle
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    Image(systemName: configuration.isOn ? "rectangle.fill" : "")
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
            
            configuration.label
            
        }
    }
}

// MARK: - Date Picker Text Field
/// - Connecting UIKit DatePicker to SwiftUI.
/// I'm using it only to Conform to App Design tho
struct DatePickerTextField: UIViewRepresentable {
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    var placeholder: String
    @Binding var date: Date?
    
    func makeUIView(context: Context) -> UITextField {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(
            helper,
            action: #selector(helper.dateValueChanged),
            for: .valueChanged
        )
        textField.placeholder = placeholder
        textField.inputView = datePicker
        
        /// - Accessory View
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: helper,
            action: #selector(helper.doneButtonAction)
        )
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        helper.dateChanged = {
            date = datePicker.date
        }
        
        helper.doneButtonTapped = {
            if date == nil {
                date = datePicker.date
            }
            self.textField.resignFirstResponder()
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = date {
            uiView.text = dateFormatter.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper {
        var dateChanged: (() -> Void)?
        var doneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            dateChanged?()
        }
        
        @objc func doneButtonAction() {
            doneButtonTapped?()
        }
    }
}






//struct NewOrderView: View {
//    @ObservedResults(Order_.self) var orders
//
//    // MARK: - State Properties
//    @State private var sourceAddress = ""
//    @State private var destinationAddress = ""
//    @State private var senderName = ""
//    @State private var isAgreededPrivacy = false
//    @State private var isShowingAlert = false
//
//    // MARK: - Init
//    init(
//        sourceAddress: String = "",
//        destinationAddress: String = "",
//        senderName: String = ""
//    ) {
//        self.sourceAddress = sourceAddress
//        self.destinationAddress = destinationAddress
//        self.senderName = senderName
//    }
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading) {
//                    HStack {
//                        Text("Оформление доставки")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
//
//                        Spacer()
//
//                        Image("bricks")
//                            .resizable()
//                            .frame(width: 83, height: 65)
//                    }
//                    .padding(.horizontal)
//                    .padding(.bottom, 90)
//
//                    Divider()
//
//                    VStack(alignment: .leading) {
//                        Text("Маршрут")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
//                            .padding(.leading)
//
//                        VStack {
//                            InputView(
//                                text: $sourceAddress,
//                                title: "Откуда:",
//                                placeholder: "Адрес отправки"
//                            )
//
//                            InputView(
//                                text: $destinationAddress,
//                                title: "Куда:",
//                                placeholder: "Адрес доставки"
//                            )
//                        }
//                        .hAlign(.center)
//                    }
//                    .padding(.bottom, 50)
//
//                    Divider()
//
//                    VStack(alignment: .leading) {
//                        Text("Контактные данные")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
//                            .padding(.leading)
//
//                        VStack {
//                            InputView(
//                                text: $senderName,
//                                title: "Отправитель:",
//                                placeholder: "Иванов Иван Иванович"
//                            )
//                        }
//                        .hAlign(.center)
//                    }
//                    .padding(.bottom, 20)
//
//
//                    Button {
//                        let order = Order_()
//                        order.trackingNumber = ""
//                        order.status = ""
//                        order.sourceAddress = sourceAddress
//                        order.destinationAddress = destinationAddress
//                        order.senderName = senderName
//
//                        $orders.append(order)
//                    } label: {
//                        HStack {
//                            Text("Отправить заявку")
//                                .font(.title2)
//                                .foregroundStyle(.white)
//                                .fontWeight(.semibold)
//                        }
//                        .padding(.top, 10)
//                        .padding(.bottom, 5)
//                        .padding([.leading, .trailing], 16)
//                        .foregroundStyle(.white)
//                    }
//                    .background {
//                        Capsule()
//                            .fill(Color(hex: 0x00CCA6, alpha: 1))
//                    }
//                    .hAlign(.center)
//                    .disabled(!isAgreededPrivacy)
//                    .opacity(isAgreededPrivacy ? 1 : 0.3)
//                    .alert(
//                        "Готово",
//                        isPresented: $isShowingAlert,
//                        actions: {
//                            Button("OK") {
//                                sourceAddress = ""
//                                destinationAddress = ""
//                                senderName = ""
//                                isAgreededPrivacy = false
//                            }
//                        },
//                        message: {
//                            Text("Ваша заявка успешно зарегистрирована. Можете посмотреть Ваши заявки разделе Заказы")
//                        }
//                    )
//                }
//                .navigationTitle("Logistix")
//            }
//        }
//    }
//}
