//
//  BuyStatus.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 05/09/24.
//

import Foundation

enum BuyStatus: Int {
    case waitingForPayment = 1
    case processed = 2
    case onDelivery = 3
    case delivered = 4
    
    var desc: String {
        switch self {
        case .waitingForPayment:
            return LocalizableString.Transactions.waitingForPayment
        case .processed:
            return LocalizableString.Transactions.onProcess
        case .onDelivery:
            return LocalizableString.Transactions.onDelivery
        case .delivered:
            return LocalizableString.Transactions.delivered
        }
    }
}
