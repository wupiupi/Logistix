//
//  OrdersView.swift
//  Logistix
//
//  Created by Paul Makey on 12.05.24.
//

import SwiftUI

struct ToggleStates {
    var oneIsOn: Bool = false
    var twoIsOn: Bool = true
}

struct OrdersView: View {
    
    @State private var toggleStates = ToggleStates()
    @State private var searchTerm = ""
    @State private var isViewExpanded = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    Text("Текущие заказы")
                        .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    DisclosureGroup("Сортировать", isExpanded: $isViewExpanded) {
                        HStack {
                            
                        }
                    }
                    .disclosureGroupStyle(CustomDisclosureStyle())
                }
                .padding()
                .navigationTitle("Logistix")
                .toolbarBackground(
                    LinearGradient(
                        colors: [
                            Color(hex: 0x00CCA6, alpha: 1),
                            Color(hex: 0x29B197, alpha: 1)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    for: .navigationBar
                )
            }
            
            .searchable(
                text: $searchTerm,
                prompt: "Поиск по документам или заказам"
            )
        }
    }
}

// MARK: - CustomDisclosureStyle
struct CustomDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                withAnimation(.linear) {
                    configuration.isExpanded.toggle()
                }
            } label: {
                HStack(alignment: .firstTextBaseline) {
                    /// - Configuring Text
                    configuration.label
                        .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                        .font(.title2)
                    
                    Spacer()
                    
                    /// - Configuring Image
                    Image(systemName: configuration.isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(Color(hex: 0x9495AA))
                        .font(.caption.lowercaseSmallCaps())
                        .animation(nil, value: configuration.isExpanded)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            if configuration.isExpanded {
                configuration.content
            }
        }
    }
}

#Preview {
    OrdersView()
}

