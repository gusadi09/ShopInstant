//
//  OffersDefaultRemoteDataSource.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation

final class OffersDefaultRemoteDataSource: OffersRemoteDataSource {
    
    private let network: ShopInstantNetwork
    
    init(network: ShopInstantNetwork = ShopInstantDefaultNetwork()) {
        self.network = network
    }
    
    func getOffers() async throws -> OffersResponse {
        try await network.request(path: "/offers", method: .get, body: nil, responseType: OffersResponse.self)
    }
}
