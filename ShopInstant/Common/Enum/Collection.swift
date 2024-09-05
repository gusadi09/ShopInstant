//
//  Collection.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 05/09/24.
//

import Foundation

enum Collection {
    case offers
    case buyItems
    
    var id: String {
        switch self {
        case .offers:
            return "offers"
        case .buyItems:
            return "buy_items"
        }
    }
}
