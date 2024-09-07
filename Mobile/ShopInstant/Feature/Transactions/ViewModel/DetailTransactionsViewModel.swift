//
//  DetailTransactionsViewModel.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import SwiftUI

final class DetailTransactionsViewModel: ObservableObject {
    @Published var item: TransactionsViewModel.PresentModel
    
    init(item: TransactionsViewModel.PresentModel) {
        self.item = item
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
    
    func totalDisc(price: String, disc: Int) -> String {
        "\(((Int(price) ?? 0) * (disc) / 100))".currency
    }
}
