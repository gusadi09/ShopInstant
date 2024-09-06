//
//  LozalizableString.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 03/09/24.
//

import Foundation

enum LocalizableString {
    enum General {
        static let attention = String(localized: "attention")
        static let ok = String(localized: "ok")
    }
    
    enum Offers {
        static let offers = String(localized: "offers")
        static let buyNow = String(localized: "buy_now")
        static let emptyOffers = String(localized: "empty_offers")
    }
    
    enum Transactions {
        static let transactions = String(localized: "transactions")
        static let purchasedDetail = String(localized: "purchased_detail")
        static let successPurchased = String(localized: "success_purchased")
        static let emptyTransaction = String(localized: "empty_transaction")
        static let waitingForPayment = String(localized: "waiting_for_payment")
        static let onProcess = String(localized: "on_process")
        static let onDelivery = String(localized: "on_delivery")
        static let delivered = String(localized: "delivered")
        static let subtotal = String(localized: "subtotal")
        static let discount = String(localized: "discount")
        static let grandTotal = String(localized: "grand_total")
    }
}
