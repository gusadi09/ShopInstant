//
//  Transaction.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import Foundation

typealias TransactionsResponse = [Transaction]

struct Transaction: Codable, Identifiable {
    let id: UUID?
    let itemName: String?
    let itemImageUrl: String?
    let itemPrice: String?
    let itemDiscount: Int?
    let itemDesc: String?
    let itemStatus: Int?
    
    func toTransactionPresentModel() ->  TransactionsViewModel.PresentModel {
        TransactionsViewModel.PresentModel(
            title: itemName,
            picture: itemImageUrl,
            price: itemPrice,
            discount: itemDiscount,
            desc: itemDesc,
            status: itemStatus
        )
    }
}
