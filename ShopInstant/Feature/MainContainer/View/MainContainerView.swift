//
//  ContentView.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 03/09/24.
//

import SwiftUI

struct MainContainerView: View {
    
    @StateObject var viewModel = MainContainerViewModel()
    
    var body: some View {
        TabView {
            ShopsView()
                .tabItem {
                    Image(systemName: "handbag.fill")
                    Text(LocalizableString.Offers.offers)
                }
            
            TransactionsView()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard.fill")
                    Text(LocalizableString.Transactions.transactions)
                }
        }
    }
}

#Preview {
    MainContainerView()
}
