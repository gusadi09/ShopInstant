//
//  Offer.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation

typealias OffersResponse = [Offer]

struct Offer: Codable, Identifiable {
    let id: UUID?
    let offerName: String?
    let offerImageUrl: String?
    let offerPrice: String?
    let offerDiscount: Int?
    let offerDesc: String?
    
    func toOfferPresentModel() ->  ShopsViewModel.PresentModel {
        ShopsViewModel.PresentModel(
            title: offerName,
            picture: offerImageUrl,
            price: offerPrice,
            discount: offerDiscount,
            desc: offerDesc
        )
    }
}
