//
//  DetailOfferView.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 05/09/24.
//

import SwiftUI

struct DetailOfferView: View {
    @Binding var isLoading: Bool
    @Binding var isSuccess: Bool
    @Binding var error: (Bool, String?)
    let item: ShopsViewModel.PresentModel
    let buyAction: () -> Void
    
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
                        .alert(isPresented: $error.0, content: {
                            Alert(
                                title: Text(LocalizableString.General.attention),
                                message: Text(error.1 ?? ""),
                                dismissButton: .default(Text(LocalizableString.General.ok))
                            )
                        })
                        
                        Text(item.title ?? "")
                            .font(.system(size: 24, weight: .bold))
                            .lineLimit(3)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 10) {
                                Text(item.price?.currency ?? "")
                                    .strikethrough(true, pattern: .solid, color: .red)
                                    .font(.system(size: 18, weight: .regular))
                                
                                if let discount = item.discount {
                                    Text("\(discount)%")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(.pink)
                                        .padding(4)
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .foregroundStyle(.red.opacity(0.2))
                                        )
                                }
                            }
                            
                            if let discount = item.discount {
                                Text(priceAfterDisc(price: item.price ?? "", disc: discount))
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.red)
                            }
                        }
                        
                        Text(LocalizedStringKey(item.desc ?? ""))
                            .padding(.vertical)
                    }
                    .padding()
                }
                
                VStack {
                    Button(action: buyAction, label: {
                        Text(LocalizableString.Offers.buyNow)
                    })
                    .buttonStyle(PrimaryButton(height: 48, bgColor: .black, textColor: .yellow))
                    .padding()
                }
                .background(
                    Rectangle()
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 3)
                        .ignoresSafeArea()
                )
                .alert(isPresented: $isSuccess, content: {
                    Alert(
                        title: Text(LocalizableString.Transactions.successPurchased),
                        message: Text(LocalizableString.Transactions.purchasedDetail),
                        dismissButton: .default(Text(LocalizableString.General.ok))
                    )
                })
            }
            
            if isLoading {
                LoadingView()
                    .ignoresSafeArea()
            }
        }
    }
    
    func priceAfterDisc(price: String, disc: Int) -> String {
        let count = (Int(price) ?? 0) - (((Int(price) ?? 0) * disc / 100))
        return String(count).currency
    }
}

#Preview {
    DetailOfferView(isLoading: .constant(false), isSuccess: .constant(false), error: .constant((false, nil)), item: ShopsViewModel.PresentModel(title: "test", picture: "", price: "10000", discount: 10, desc: ""), buyAction: {})
}
