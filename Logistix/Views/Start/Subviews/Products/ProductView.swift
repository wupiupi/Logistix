import SwiftUI

struct ProductView: View {
    let imageName: String
    let text: String
    let subtext: String?
    var articles: [String]
    
    init(
        imageName: String,
        text: String,
        subtext: String? = nil,
        articles: String...
    ) {
        self.imageName = imageName
        self.text = text
        self.subtext = subtext
        self.articles = articles
    }
    
    var body: some View {
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
            
            if let subtext = subtext {
                Text(subtext)
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundStyle(.secondary)
                    .hAlign(.center)
                    .padding(.top, -20)
            }
            
            ForEach(articles, id: \.self) {
                Text("• \($0)")
            }
            .foregroundStyle(.black)
            .padding(.leading, 12)
            .hAlign(.leading)
            .font(.subheadline)
            
            ProductButtonView()
            
        }
        .padding(.vertical, 35)
        .hAlign(.center)
        .background {
            RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
        }
        .padding(.horizontal, 15)
    }
}

struct ProductButtonView: View {
    var body: some View {
        NavigationLink {
            RegistrationView()
        } label: {
            Text("Попробовать")
                .font(.title2)
                .fontWeight(.semibold)
                .padding([.leading, .trailing], 16)
                .padding([.top, .bottom], 15)
                .foregroundStyle(.menuText)
                .background {
                    RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                        .fill(.greenButton)
                }
        }
        .frame(width: UIScreen.main.bounds.width - 32)
    }
}
