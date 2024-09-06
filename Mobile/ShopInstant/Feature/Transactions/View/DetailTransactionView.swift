//
//  DetailTransactionView.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import SwiftUI

struct DetailTransactionView: View {
    let item: TransactionsViewModel.PresentModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        GeometryReader(content: { geometry in
                            WebImageLoaderView(
                                url: item.picture ?? "empty",
                                width: geometry.size.width,
                                height: geometry.size.height,
                                aspectRatio: .fill
                            )
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.gray))
                        })
                        .frame(height: 250)
                        
                        Text(item.title ?? "")
                            .font(.system(size: 24, weight: .bold))
                            .lineLimit(3)
                        
                        Text(LocalizedStringKey(item.desc ?? ""))
                            .padding(.vertical)
                    }
                    .padding()
                }
                
                VStack(spacing: 10) {
                    
                    HStack {
                        Text(LocalizableString.Transactions.subtotal)
                            .font(.system(size: 14, weight: .regular))
                        
                        Spacer()
                        
                        Text(item.price?.currency ?? "")
                            .font(.system(size: 14, weight: .bold))
                    }
                    
                    if let discount = item.discount {
                        HStack {
                            Text(LocalizableString.Transactions.discount)
                                .font(.system(size: 14, weight: .regular))
                            
                            Spacer()
                            
                            Text("-"+"\(((Int(item.price ?? "0") ?? 0) * (discount) / 100))".currency)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.red)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text(LocalizableString.Transactions.grandTotal)
                            .font(.system(size: 14, weight: .regular))
                        
                        Spacer()
                        
                        Text(priceAfterDisc(price: item.price ?? "0", disc: item.discount ?? 0))
                            .font(.system(size: 14, weight: .bold))
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Spacer()
                        
                        Text(item.statusDesc ?? "")
                            .foregroundStyle(
                                textStatusColor(status: item.status)
                            )
                            .font(.system(size: 14, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .frame(height: 48)
                    .background(
                        backgroundStatusColor(status: item.status)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
                .background(
                    Rectangle()
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 3)
                        .ignoresSafeArea()
                )
            }
        }
    }
    
    func priceAfterDisc(price: String, disc: Int) -> String {
        let count = (Int(price) ?? 0) - (((Int(price) ?? 0) * disc / 100))
        return String(count).currency
    }
    
    func textStatusColor(status: BuyStatus?) -> Color {
        switch status {
        case .waitingForPayment:
            return .orange
        case .processed:
            return .blue
        case .onDelivery:
            return .purple
        case .delivered:
            return .green
        case .none:
            return .orange
        }
    }
    
    func backgroundStatusColor(status: BuyStatus?) -> Color {
        switch status {
        case .waitingForPayment:
            return Color.yellow.opacity(0.3)
        case .processed:
            return Color.blue.opacity(0.2)
        case .onDelivery:
            return Color.indigo.opacity(0.2)
        case .delivered:
            return Color.green.opacity(0.2)
        case .none:
            return Color.yellow.opacity(0.3)
        }
    }
}

#Preview {
    DetailTransactionView(item: TransactionsViewModel.PresentModel(title: "test", picture: "", price: "10000", discount: 10, desc: "", status: BuyStatus.processed.rawValue))
}
