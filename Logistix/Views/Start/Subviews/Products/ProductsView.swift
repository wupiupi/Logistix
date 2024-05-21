//
//  ProductsView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct ProductsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Продукты\nплатформы")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ProductView(
                imageName: "hammer.right",
                text: "Транспортные тендеры",
                articles: "Прозрачность процесса закупок",
                "Автоматизация распределения объемов",
                "Консолидированная отчетность",
                "Хранение результатов и истории торгов"
            )
            
            ProductView(
                imageName: "hammer.left",
                text: "Спот-аукционы",
                articles: "Оперативное закрытие срочных перевозок",
                "Три вида аукционов: на понижение, первого согласия, без стартовой цены"
            )
            
            ProductView(
                imageName: "gear",
                text: "TMS / Система управления перевозками",
                articles: "Фиксация и учет договорных условий",
                "Автоматизация логистических процессов",
                "Возможность настройки под конкретные задачи"
            )
            
            ProductView(
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
    }
}

#Preview {
    ProductsView()
}
