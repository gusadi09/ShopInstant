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
            Text(LocalizableString.Transactions.transactions)
                .navigationTitle(LocalizableString.Transactions.transactions)
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    TransactionsView()
}
