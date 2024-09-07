//
//  DetailOfferViewModel.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import Foundation

final class DetailOfferViewModel: ObservableObject {
    @Published var item: ShopsViewModel.PresentModel
    let buyAction: () -> Void
    
    init(item: ShopsViewModel.PresentModel, buyAction: @escaping () -> Void) {
        self.item = item
        self.buyAction = buyAction
    }
    
    func priceAfterDisc(price: String, disc: Int) -> String {
        let count = (Int(price) ?? 0) - (((Int(price) ?? 0) * disc / 100))
        return String(count).currency
    }
}
