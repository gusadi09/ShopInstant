//
//  TransactionsView.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 03/09/24.
//

import SwiftUI

struct TransactionsView: View {
    
    @StateObject var viewModel = TransactionsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0...4, id: \.self) { _ in
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
                    .listRowInsets(EdgeInsets(top: 20, leading: 18, bottom: 20, trailing: 18))
                }
            }
            .listStyle(.plain)
            .navigationTitle(LocalizableString.Transactions.transactions)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    TransactionsView()
}
