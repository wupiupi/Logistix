//
//  Applications.swift
//  Logistix
//
//  Created by Serge Broski on 5/20/24.
//

import SwiftUI
import RealmSwift

struct Applications: View {
    // Wrappers
    @ObservedResults(ApplicationForm.self) var applications
    
    @State private var searchTerm = ""
    @State private var isViewExpanded = false
    
    // Computing Properties
    private var filteredApplications: [ApplicationForm] {
        guard !searchTerm.isEmpty else { return Array(applications) }
        return applications.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Заявки")
                        .modifier(TitleModifier(font: .largeTitle, fontWeight: .semibold))
                    
                    if applications.isEmpty {
                        Text("Заявок нет")
                    }
                                        
                    ForEach(filteredApplications, id: \.self) { application in
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("№ \(application.id)")
                                    .font(.title3)
                                    .foregroundStyle(Color(hex: 0x00CCA6, alpha: 1))
                                    .padding([.top, .bottom], 8)
                                    .padding([.leading, .trailing], 8)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.main.opacity(0.2))
                                    }
                                
                                Spacer()
                                
                                Text(dateFormatter.string(from: application.date))
                                    .font(.title3)
                            }
                            
                            ExpandableView(
                                thumbnail: ThumbnailView(content: {
                                    VStack {
                                        Text("Открыть")
                                            .modifier(
                                                TitleModifier(
                                                    font: .title,
                                                    fontWeight: .semibold
                                                )
                                            )
                                    }
                                    .padding()
                                }),
                                expanded: ExpandedView(content: {
                                    VStack(alignment: .center, spacing: 20) {
                                        Text("№ \(application.id)")
                                            .modifier(TitleModifier(font: .title, fontWeight: .bold))
                                        
                                        TrackDetail(
                                            title: "Имя контакта",
                                            orderInfo: application.name
                                        )
                                        TrackDetail(
                                            title: "Электронная почта",
                                            orderInfo: application.email
                                        )
                                        TrackDetail(
                                            title: "Компания",
                                            orderInfo: application.company
                                        )
                                        TrackDetail(
                                            title: "Контактный телефон",
                                            orderInfo: application.phone
                                        )
                                        
                                        
                                        Text("Статус")
                                            .font(.title3)
                                            .foregroundStyle(.gray)
                                        
                                        Text(application.status)
                                            .font(.title3)
                                            .foregroundStyle(
                                                Color(
                                                    hex: 0x00CCA6,
                                                    alpha: 1
                                                )
                                            )
                                            .padding([.top, .bottom], 8)
                                            .padding([.leading, .trailing], 8)
                                            .background {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(.main.opacity(0.2))
                                            }
                                        
                                        Button {
                                            try! Realm().write {
                                                application.thaw()?.status = "Отвечено"
                                            }
                                        } label: {
                                            Text("Подтвердить ответ")
                                                .font(.title2)
                                                .foregroundStyle(.white)
                                                .padding()
                                                .background {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(.green)
                                                }
                                        }
                                    }
                                    .padding()
                                    .hAlign(.center)
                                })
                            )
                        }
                    }
                }
                .padding()
                .navigationTitle("Logistix")
                .toolbarBackground(
                    LinearGradient(
                        colors: [
                            Color(hex: 0x00CCA6, alpha: 1),
                            Color(hex: 0x29B197, alpha: 0.5)
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

#Preview {
    Applications()
}
