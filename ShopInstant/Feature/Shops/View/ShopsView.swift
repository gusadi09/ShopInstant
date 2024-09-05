//
//  ShopsView.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 03/09/24.
//

import SwiftUI

struct ShopsView: View {
    
    @StateObject var viewModel = ShopsViewModel()
    @State var height: CGFloat = 1
    
    var body: some View {
        GeometryReader(content: { geometry in
            NavigationStack {
                ZStack {
                    ScrollView {
                        if viewModel.items.isEmpty {
                            VStack(spacing: 15) {
                                Image(systemName: "handbag.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width/2)
                                    .foregroundStyle(.gray)
                                
                                Text(LocalizableString.Offers.emptyOffers)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(.gray)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .padding(.top, 30)
                        } else {
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(
                                        minimum: 60,
                                        maximum: geometry.size.width)
                                    ),
                                    GridItem(.flexible(
                                        minimum: 60,
                                        maximum: geometry.size.width)
                                    )
                                ],
                                spacing: 15,
                                content: {
                                    ForEach(viewModel.items, id: \.id) { item in
                                        OfferCard(items: item)
                                            .onTapGesture {
                                                viewModel.selectedItem = item
                                            }
                                            .sheet(item: $viewModel.selectedItem) { item in
                                                DetailOfferView(
                                                    isLoading: $viewModel.isLoading,
                                                    isSuccess: $viewModel.successToBuy,
                                                    item: item
                                                ) {
                                                    Task {
                                                        await viewModel.buyNow(from: item)
                                                    }
                                                }
                                            }
                                    }
                                }
                            )
                            .padding()
                        }
                    }
                    .refreshable {
                        await viewModel.fetchOffers()
                    }
                    .alert(isPresented: $viewModel.error.0, content: {
                        Alert(
                            title: Text(LocalizableString.General.attention),
                            message: Text(viewModel.error.1 ?? ""),
                            dismissButton: .default(Text(LocalizableString.General.ok))
                        )
                    })
                    
                    if viewModel.isLoading {
                        LoadingView()
                    }
                }
                .navigationTitle(LocalizableString.Offers.offers)
                .navigationBarTitleDisplayMode(.large)
                .task {
                    await viewModel.fetchOffers()
                }
            }
        })
    }
}

#Preview {
    ShopsView()
}
