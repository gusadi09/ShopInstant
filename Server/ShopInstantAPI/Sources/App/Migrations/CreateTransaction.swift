//
//  File.swift
//  
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation
import Fluent

struct CreateTransaction: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("transactions")
            .id()
            .field("itemName", .string, .required)
            .field("itemImageUrl", .string, .required)
            .field("itemPrice", .string, .required)
            .field("itemDiscount", .int)
            .field("itemDesc", .string, .required)
            .field("itemStatus", .int, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("transactions").delete()
    }
}
