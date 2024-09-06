//
//  File.swift
//  
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation
import Fluent

struct CreateOffer: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("offers")
            .id()
            .field("offerName", .string, .required)
            .field("offerImageUrl", .string, .required)
            .field("offerPrice", .string, .required)
            .field("offerDiscount", .int)
            .field("offerDesc", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("offers").delete()
    }
}
