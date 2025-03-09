import SwiftUI

struct ProductsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Возможности\nплатформы")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ProductView(
                imageName: "hammer.right",
                text: "Регистрация как поставщик или водитель",
                articles: "Есть груз, который нужно доставить?",
                "Есть личный автомобиль и Вы хотите заработать?",
                "Планируете поездку и готовы захватить с собой посылку?"
            )
            
            ProductView(
                imageName: "hammer.left",
                text: "Размещяй или принимай заказы!",
                articles: "Оперативное создание и принятие заказов",
                "Возможность взять несколько заказов для выполнения по удобному Вам маршруту"
            )
            
            ProductView(
                imageName: "gear",
                text: "Нет посредников",
                articles: "У нас нет посредников",
                "Прямое общение между поставщиком и доставщиком"
            )
            
            ProductView(
                imageName: "locator",
                text: "Отслеживание статуса заказа",
                subtext: "С возможностью их поиска",
                articles: "Смотрите, на какой стадии доставки Ваш заказ",
                "Наглядное отображение статуса заказа",
                "Много заказов? Найдите нужный Вам по удобому поиску!"
            )
            
        }
        .padding(.vertical, 20)
        .background {
            Color.startMint
        }
        .padding(.bottom, -10)
    }
}
