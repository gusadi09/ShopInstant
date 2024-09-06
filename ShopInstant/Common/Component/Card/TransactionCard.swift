//
//  TransactionCard.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 05/09/24.
//

import SwiftUI

struct TransactionCard: View {
    
    let item: TransactionsViewModel.PresentModel
    
    var body: some View {
        HStack(spacing: 10) {
            WebImageLoaderView(
                url: item.picture,
                width: 80,
                height: 80,
                aspectRatio: .fill
            )
            .frame(width: 80, height: 80)
            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.gray))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.1), radius: 4)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(item.title ?? "")
                    .font(.system(size: 16, weight: .bold))
                    .lineLimit(1)
                
                switch item.status {
                case .waitingForPayment:
                    Text(item.statusDesc ?? "")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.orange)
                        .padding(5)
                        .background(
                            Color.yellow.opacity(0.3)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .processed:
                    Text(item.statusDesc ?? "")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.blue)
                        .padding(5)
                        .background(
                            Color.blue.opacity(0.2)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                case .onDelivery:
                    Text(item.statusDesc ?? "")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.purple)
                        .padding(5)
                        .background(
                            Color.indigo.opacity(0.2)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                case .delivered:
                    Text(item.statusDesc ?? "")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.green)
                        .padding(5)
                        .background(
                            Color.green.opacity(0.2)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                case .none:
                    EmptyView()
                }
                
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 8)
                .font(.system(size: 6, weight: .bold, design: .rounded))
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    TransactionCard(
        item: TransactionsViewModel.PresentModel(
            title: "HEAD Speed MP 100g",
            picture: "https://images.tennis.com/image/private/t_16-9_768/tenniscom-prd/bxdgpnfje6infmzwwix6.jpg",
            price: "1300000",
            discount: 10,
            desc: "",
            status: 1
        )
    )
    .onTapGesture {
        print("test")
    }
}
