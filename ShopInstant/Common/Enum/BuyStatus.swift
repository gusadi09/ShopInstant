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
}
