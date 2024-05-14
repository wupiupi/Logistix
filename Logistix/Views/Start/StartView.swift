//
//  StartView.swift
//  Logistix
//
//  Created by Paul Makey on 11.05.24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                /// - Setting Backround color
                Color(hex: 0xB2B2B2, alpha: 1)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        NavigationLink {
                            LoginView()
                        } label: {
                            CustomButtonView(
                                title: "Вход",
                                systemImage: "arrowshape.right.fill"
                            )
                        }
                        NavigationLink {
                            RegistrationView()
                        } label: {
                            CustomButtonView(
                                title: "Регистрация",
                                systemImage: "arrowshape.right.fill"
                            )
                        }
                    }
                    .padding(.trailing, 50)
                    .padding(.top, 200)
                    .background {
                        Image("trucks")
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: UIScreen.main.bounds.midX,
                                height: UIScreen.main.bounds.height / 1.7
                            )
                            .padding(.bottom, 175)
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                    
                    // TODO: - Extract to SubView or InterfaceBuilder Method
                    VStack(alignment: .leading) {
                        Image("handshake")
                            .resizable()
                            .frame(width: 66, height: 66)
                        
                        Text("Более 6 000 перевозчиков работают с нами")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 30)
                    .background {
                        Rectangle()
                            .fill(.white)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                    
                    VStack(alignment: .leading) {
                        Image("truck")
                            .resizable()
                            .frame(width: 66, height: 66)
                        
                        Text("Свыше 100 000 рейсов в год")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 30)
                    .background {
                        Rectangle()
                            .fill(.white)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                    
                    VStack(alignment: .leading) {
                        Image("insurance")
                            .resizable()
                            .frame(width: 66, height: 66)
                        
                        Text("Своя служба безопасности")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 30)
                    .background {
                        Rectangle()
                            .fill(Color(hex: 0x00CCA6, alpha: 1))
                            .frame(width: UIScreen.main.bounds.width)
                    }
                    .padding(.bottom, -10)
                    
                    VStack(spacing: 20) {
                        VStack {
                            Text("Продукты")
                            Text("платформы")
                        }
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .hAlign(.center)
                        
                        FeatureView(
                            imageName: "hammer.right",
                            text: "Транспортные тендеры",
                            articles: "Прозрачность процесса закупок",
                            "Автоматизация распределения объемов",
                            "Консолидированная отчетность",
                            "Хранение результатов и истории торгов"
                        )
                        
                        FeatureView(
                            imageName: "hammer.left",
                            text: "Спот-аукционы",
                            articles: "Оперативное закрытие срочных перевозок",
                            "Три вида аукционов: на понижение, первого согласия, без стартовой цены"
                        )
                        
                        FeatureView(
                            imageName: "gear",
                            text: "TMS / Система управления перевозками",
                            articles: "Фиксация и учет договорных условий",
                            "Автоматизация логистических процессов",
                            "Возможность настройки под конкретные задачи"
                        )
                        
                        FeatureView(
                            imageName: "locator",
                            text: "Трекинг грузов",
                            subtext: "Все виды отслеживания",
                            articles: "Бортовые блоки",
                            "GSM-связь",
                            "Мобильное приложение"
                        )
                    }
                    .padding(.vertical, 20)
                    .background {
                        Color(hex: 0xF3FFFD, alpha: 1)
                    }
                    .padding(.bottom, -10)
                    
                    VStack(alignment: .leading) {
                        Text("Для перевозчиков")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundStyle(.green)
                                .frame(width: 32, height: 32)
                            
                            Text("Все грузовладельцы на одной платформе – получайте выгодные заказы")
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundStyle(.green)
                                .frame(width: 32, height: 32)
                            
                            Text("Только выгодные рейсы – наши перевозчики зарабатывают более 200 000 рублей в год с каждой машины")
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundStyle(.green)
                                .frame(width: 32, height: 32)
                            
                            Text("Гарантия загрузки – более 70 000 рейсов")
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                        // TODO: - Extract to Separate View
                        NavigationLink {
                            RegistrationView()
                        } label: {
                            Text("Присоединяйтесь")
                                .font(.title2)
                                .padding(.leading, 16)
                                .padding(.trailing, 16)
                                .padding(.top, 15)
                                .padding(.bottom, 10)
                                .foregroundStyle(.white)
                                .background {
                                    Capsule()
                                        .fill(Color(hex: 0x00CCA6, alpha: 1))
                                }
                        }
                        .frame(width: UIScreen.main.bounds.width - 32)
                    }
                    .padding([.leading, .trailing], 8)
                    .padding(.vertical, 35)
                    .background {
                        Rectangle()
                            .fill(Color(hex: 0x252B42, alpha: 1))
                    }
                    .padding(.bottom, -10)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 15)  {
                            Button {
                                print("DEBUG: Документы")
                            } label: {
                                Text("Документы")
                            }
                            Button {
                                print("DEBUG: Политика конфиденциальности")
                            } label: {
                                Text("Политика конфиденциальности")
                            }
                            Button {
                                print("DEBUG: Пользовательское соглашение")
                            } label: {
                                Text("Пользовательское соглашение")
                            }
                        }
                        .fontWeight(.bold)
                        .hAlign(.leading)
                        .padding(.bottom, 40)
                        
                        Text("Контакты")
                            .fontWeight(.bold)
                        
                        HStack {
                            Image("phone")
                                .resizable()
                                .foregroundStyle(Color(hex: 0x00CCA6, alpha: 1))
                                .frame(width: 22.81, height: 22.81)
                            
                            Text("+375(29)555-66-77")
                        }
                        
                        
                        HStack {
                            Image("location")
                                .resizable()
                                .foregroundStyle(Color(hex: 0x00CCA6, alpha: 1))
                                .frame(width: 24, height: 26)
                            
                            Text("г. Минск, ул. Петруся Бровки, д. 2")
                        }
                        
                        HStack {
                            Image("email")
                                .resizable()
                                .foregroundStyle(Color(hex: 0x00CCA6, alpha: 1))
                                .frame(width: 24, height: 24)
                            
                            Text("info@logistix.by")
                                .foregroundStyle(.black)
                        }
                        
                        HStack(spacing: 25) {
                            Button {
                                print("DEBUG: First Social Media was Tapped")
                            } label: {
                                Image("facebook.icon")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                            }
                            
                            Button {
                                print("DEBUG: Second Social Media was Tapped")
                            } label: {
                                Image("instagram.icon")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                            }
                            
                            Button {
                                print("DEBUG: Third Social Media was Tapped")
                            } label: {
                                Image("twitter.icon")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                            }
                        }
                    }
                    .padding(.leading, 8)
                    .padding(.vertical, 35)
                    .background {
                        Rectangle()
                            .fill(.white)
                    }
                    .foregroundStyle(.black)
                    .padding(.bottom, -33)
                    
                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Logistix")
            .toolbarBackground(.ultraThickMaterial, for: .navigationBar)
        }
    }
    
    // MARK: - Feature View
    @ViewBuilder
    func FeatureView(
        imageName: String,
        text: String,
        subtext: String = "",
        articles: String...
    ) -> some View {
        VStack(alignment: .leading, spacing: 25) {
            Image(imageName)
                .resizable()
                .frame(width: 102, height: 102)
                .hAlign(.center)
            
            Text(text)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .hAlign(.center)
            
            Text(subtext)
                .font(.caption)
                .fontWeight(.light)
                .foregroundStyle(.secondary)
                .hAlign(.center)
                .padding(.top, -20)
            
            ForEach(articles, id: \.self) {
                Text("• \($0)")
            }
            .foregroundStyle(.black)
            .hAlign(.center)
            .font(.subheadline)
            
            // TODO: - Extract to Separate View
            NavigationLink {
                RegistrationView()
            } label: {
                Text("Попробовать")
                    .font(.title2)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .padding(.top, 15)
                    .padding(.bottom, 10)
                    .foregroundStyle(.white)
                    .background {
                        Capsule()
                            .fill(Color(hex: 0x00CCA6, alpha: 1))
                    }
            }
            .frame(width: UIScreen.main.bounds.width - 32)
        }
        .padding(.vertical, 35)
        .hAlign(.center)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    StartView()
}
