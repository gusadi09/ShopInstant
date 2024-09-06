//
//  OffersRemoteDataSource.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation

protocol OffersRemoteDataSource {
    func getOffers() async throws -> OffersResponse
}
