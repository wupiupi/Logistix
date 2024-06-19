//
//  ProductView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

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
                            .fill(.main)
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
    ProductView(
        imageName: "hammer.right",
        text: "Транспортные тендеры"
    )
}
