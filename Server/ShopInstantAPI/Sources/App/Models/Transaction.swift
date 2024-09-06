//
//  File.swift
//  
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation
import Fluent

final class Transaction: Model, @unchecked Sendable {
    static let schema = "transactions"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "itemName")
    var itemName: String

    @Field(key: "itemImageUrl")
    var itemImageUrl: String
    
    @Field(key: "itemPrice")
    var itemPrice: String
    
    @Field(key: "itemDiscount")
    var itemDiscount: Int?
    
    @Field(key: "itemDesc")
    var itemDesc: String
    
    @Field(key: "itemStatus")
    var itemStatus: Int

    init() {}

    init(id: UUID? = nil, itemName: String, itemImageUrl: String, itemPrice: String, itemDiscount: Int?, itemDesc: String, itemStatus: Int) {
        self.id = id
        self.itemName = itemName
        self.itemImageUrl = itemImageUrl
        self.itemPrice = itemPrice
        self.itemDiscount = itemDiscount
        self.itemDesc = itemDesc
        self.itemStatus = itemStatus
    }
    
    func toDTO() -> TransactionDTO {
        .init(
            id: self.id,
            itemName: self.$itemName.value,
            itemImageUrl: self.$itemImageUrl.value,
            itemPrice: self.$itemPrice.value,
            itemDiscount: self.itemDiscount,
            itemDesc: self.$itemDesc.value,
            itemStatus: self.$itemStatus.value
        )
    }
}
