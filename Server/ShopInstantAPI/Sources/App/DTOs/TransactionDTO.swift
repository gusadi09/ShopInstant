//
//  File.swift
//  
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation

import Vapor

struct TransactionDTO: Content {
    var id: UUID?
    var itemName: String?
    var itemImageUrl: String?
    var itemPrice: String?
    var itemDiscount: Int?
    var itemDesc: String?
    var itemStatus: Int?
    
    func toModel() -> Transaction {
        let model = Transaction()
        
        model.id = self.id
        if let itemName = self.itemName {
            model.itemName = itemName
        }
        
        if let itemImageUrl = self.itemImageUrl {
            model.itemImageUrl = itemImageUrl
        }
        
        if let itemPrice = self.itemPrice {
            model.itemPrice = itemPrice
        }
         
        if let itemDiscount = self.itemDiscount {
            model.itemDiscount = itemDiscount
        }
         
        if let itemDesc = self.itemDesc {
            model.itemDesc = itemDesc
        }
         
        if let itemStatus = self.itemStatus {
            model.itemStatus = itemStatus
        }
        
        return model
    }
}
