//
//  DetailTransactionView.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import SwiftUI

struct DetailTransactionView: View {
    @StateObject var viewModel: DetailTransactionsViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        GeometryReader(content: { geometry in
                            WebImageLoaderView(
                                url: viewModel.item.picture ?? "empty",
                                width: geometry.size.width,
                                height: geometry.size.height,
                                aspectRatio: .fill
                            )
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.gray))
                        })
                        .frame(height: 250)
                        
                        Text(viewModel.item.title ?? "")
                            .font(.system(size: 24, weight: .bold))
                            .lineLimit(3)
                        
                        Text(LocalizedStringKey(viewModel.item.desc ?? ""))
                            .padding(.vertical)
                    }
                    .padding()
                }
                
                VStack(spacing: 10) {
                    
                    HStack {
                        Text(LocalizableString.Transactions.subtotal)
                            .font(.system(size: 14, weight: .regular))
                        
                        Spacer()
                        
                        Text(viewModel.item.price?.currency ?? "")
                            .font(.system(size: 14, weight: .bold))
                    }
                    
                    if let discount = viewModel.item.discount {
                        HStack {
                            Text(LocalizableString.Transactions.discount)
                                .font(.system(size: 14, weight: .regular))
                            
                            Spacer()
                            
                            Text("-" + viewModel.totalDisc(price: viewModel.item.price ?? "0", disc: discount))
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.red)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text(LocalizableString.Transactions.grandTotal)
                            .font(.system(size: 14, weight: .regular))
                        
                        Spacer()
                        
                        Text(viewModel.priceAfterDisc(price: viewModel.item.price ?? "0", disc: viewModel.item.discount ?? 0))
                            .font(.system(size: 14, weight: .bold))
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Spacer()
                        
                        Text(viewModel.item.statusDesc ?? "")
                            .foregroundStyle(
                                viewModel.textStatusColor(status: viewModel.item.status)
                            )
                            .font(.system(size: 14, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .frame(height: 48)
                    .background(
                        viewModel.backgroundStatusColor(status: viewModel.item.status)
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
}

#Preview {
    DetailTransactionView(
        viewModel: DetailTransactionsViewModel(
            item: TransactionsViewModel.PresentModel(
                title: "test",
                picture: "",
                price: "10000",
                discount: 10,
                desc: "", status: BuyStatus.processed.rawValue
            )
        )
    )
}
