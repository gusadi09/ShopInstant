//
//  File.swift
//  
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation
import Vapor

struct OfferDTO: Content {
    var id: UUID?
    var offerName: String?
    var offerImageUrl: String?
    var offerPrice: String?
    var offerDiscount: Int?
    var offerDesc: String?
    
    func toModel() -> Offer {
        let model = Offer()
        
        model.id = self.id
        if let offerName = self.offerName {
            model.offerName = offerName
        }
        
        if let offerImageUrl = self.offerImageUrl {
            model.offerImageUrl = offerImageUrl
        }
        
        if let offerPrice = self.offerPrice {
            model.offerPrice = offerPrice
        }
         
        if let offerDiscount = self.offerDiscount {
            model.offerDiscount = offerDiscount
        }
         
        if let offerDesc = self.offerDesc {
            model.offerDesc = offerDesc
        }
         
        return model
    }
}
