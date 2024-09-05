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
                ScrollView {
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
                                        DetailOfferView(item: item) {
                                            
                                        }
                                    }
                            }
                        }
                    )
                    .padding()
                }
                .navigationTitle(LocalizableString.Offers.offers)
                .navigationBarTitleDisplayMode(.large)
            }
        })
    }
}

#Preview {
    ShopsView()
}
