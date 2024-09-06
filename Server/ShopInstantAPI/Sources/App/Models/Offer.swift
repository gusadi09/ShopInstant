//
//  File.swift
//  
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation
import Fluent

final class Offer: Model, @unchecked Sendable {
    static let schema = "offers"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "offerName")
    var offerName: String

    @Field(key: "offerImageUrl")
    var offerImageUrl: String
    
    @Field(key: "offerPrice")
    var offerPrice: String
    
    @Field(key: "offerDiscount")
    var offerDiscount: Int?
    
    @Field(key: "offerDesc")
    var offerDesc: String

    init() {}

    init(id: UUID? = nil, offerName: String, offerImageUrl: String, offerPrice: String, offerDiscount: Int?, offerDesc: String) {
        self.id = id
        self.offerName = offerName
        self.offerImageUrl = offerImageUrl
        self.offerPrice = offerPrice
        self.offerDiscount = offerDiscount
        self.offerDesc = offerDesc
    }
    
    func toDTO() -> OfferDTO {
        .init(
            id: self.id,
            offerName: self.$offerName.value,
            offerImageUrl: self.$offerImageUrl.value,
            offerPrice: self.$offerPrice.value,
            offerDiscount: self.offerDiscount,
            offerDesc: self.$offerDesc.value
        )
    }
}
