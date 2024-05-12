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
                    VStack {
                        
                        VStack(spacing: 20) {
                            CustomButton(
                                title: "Вход",
                                systemImage: "arrowshape.right.fill"
                            ) {}
                            
                            CustomButton(
                                title: "Регистрация",
                                systemImage: "arrowshape.right.fill"
                            ) {}
                        }
                        .padding(.top, 250)
                    }
                    .padding()
                    
                    Spacer()
                    
                    // TODO: - Extract to SubView or InterfaceBuilder Method
                    VStack {
                        Image("handshake")
                            .resizable()
                            .frame(width: 66, height: 66)
                        
                        Text("Более 6 000 перевозчиков работают с нами")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 20)
                    .background {
                        Rectangle()
                            .fill(.white)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                    
                    VStack {
                        Image("")
                            .resizable()
                            .frame(width: 66, height: 66)
                        
                        Text("Свыше 100 000 рейсов в год")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 20)
                    .background {
                        Rectangle()
                            .fill(.white)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                    
                    VStack {
                        Image("")
                            .resizable()
                            .frame(width: 66, height: 66)
                        
                        Text("Своя служба безопасности")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        
                    }
                    .padding(.vertical, 20)
                    .background {
                        Rectangle()
                            .fill(.white)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                    .padding(.bottom, 50)
                    
                    VStack(spacing: 20) {
                        Text("Продукты платформы")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        FeatureView(
                            imageName: "",
                            text: "Транспортные тендеры",
                            articles: "Прозрачность процесса закупок",
                            "Автоматизация распределения объемов",
                            "Консолидированная отчетность",
                            "Хранение результатов и истории торгов"
                        )
                        
                        FeatureView(
                            imageName: "",
                            text: "Спот-аукционы",
                            articles: "Оперативное закрытие срочных перевозок",
                            "Три вида аукционов: на понижение, первого согласия, без стартовой цены"
                        )
                        
                        FeatureView(
                            imageName: "",
                            text: "TMS / Система управления перевозками",
                            articles: "Фиксация и учет договорных условий",
                            "Автоматизация логистических процессов",
                            "Возможность настройки под конкретные задачи"
                        )
                        
                        FeatureView(
                            imageName: "",
                            text: "Трекинг грузов",
                            subtext: "Все виды отслеживания",
                            articles: "Бортовые блоки",
                            "GSM-связь",
                            "Мобильное приложение"
                        )
                    }
                    /// - Setting Bottom Inset
                    .padding(.bottom, 60)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Для перевозчиков")
                            .foregroundStyle(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        HStack {
                            Image("")
                                .resizable()
                                .frame(width: 32, height: 32)
                            
                            Text("Все грузовладельцы на одной платформе – получайте выгодные заказы")
                                .foregroundStyle(.white)
                        }
                        HStack {
                            Image("")
                                .resizable()
                                .frame(width: 32, height: 32)
                            
                            Text("Только выгодные рейсы – наши перевозчики зарабатывают более 200 000 рублей в год с каждой машины")
                                .foregroundStyle(.white)
                        }
                        HStack {
                            Image("")
                                .resizable()
                                .frame(width: 32, height: 32)
                            
                            Text("Гарантия загрузки – более 70 000 рейсов")
                                .foregroundStyle(.white)
                        }
                        // TODO: - Extract to Separate View
                        Button {
                            
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
                                        .foregroundStyle(.mint)
                                }
                        }
                        .frame(width: UIScreen.main.bounds.width - 32)
                    }
                    .padding(8)
                    
                    VStack(alignment: .leading, spacing: 15) {
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
                    .padding(.leading, 8)
                    .padding(.vertical, 35)
                    .background {
                        Rectangle()
                            .fill(.white)
                    }
                    .foregroundStyle(.black)
                    
                    
                }
            }
            .navigationTitle("Logistix")
            .toolbarBackground(.ultraThickMaterial, for: .navigationBar)
        }
    }
    
    // MARK: - Question View
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
            Button {
                
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
                            .foregroundStyle(.mint)
                    }
            }
            .frame(width: UIScreen.main.bounds.width - 32)
        }
        .padding(.vertical, 35)
        .hAlign(.center)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    StartView()
}
