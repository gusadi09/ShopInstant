//
//  OfferCard.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 04/09/24.
//

import SwiftUI

struct OfferCard: View {
    let items: ShopsViewModel.PresentModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            GeometryReader(content: { geometry in
                WebImageLoaderView(
                    url: items.picture,
                    width: geometry.size.width,
                    height: 120,
                    aspectRatio: .fit
                )
                .frame(width: geometry.size.width, height: 120)
                .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.gray))
            })
            .frame(height: 120)
            
            Text(items.title)
                .font(.system(size: 16, weight: .bold))
                .lineLimit(1)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 10) {
                    Text(items.price.currency)
                        .strikethrough(true, pattern: .solid, color: .red)
                        .font(.system(size: 12, weight: .regular))
                    
                    Text("\(items.discount)%")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(.pink)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(.red.opacity(0.2))
                        )
                }
                
                Text(priceAfterDisc(price: items.price, disc: items.discount))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.red)
            }
        }
        .padding([.top, .horizontal], 8)
        .padding(.bottom, 10)
        .background(
            Rectangle()
                .foregroundStyle(.background)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 6)
    }
    
    func priceAfterDisc(price: String, disc: Int) -> String {
        let count = (Int(price) ?? 0) - (((Int(price) ?? 0) * disc / 100))
        return String(count).currency
    }
}

#Preview {
    ScrollView {
        GeometryReader(content: { geometry in
            LazyVGrid(columns: [GridItem(.flexible(minimum: 60, maximum: geometry.size.width)), GridItem(.flexible(minimum: 60, maximum: geometry.size.width))], spacing: 15, content: {
                ForEach(1...4, id: \.self) { item in
                    OfferCard(items: ShopsViewModel.PresentModel(title: "test", price: "10000", discount: 10))
                        .padding(item % 2 == 0 ? .leading : .trailing, 5)
                }
            })
            .padding()
        })
    }
}
