//
//  TransactionsDefaultRemoteDataSource.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import Foundation

final class TransactionsDefaultRemoteDataSource: TransactionsRemoteDataSource {
    
    private let network: ShopInstantNetwork
    
    init(network: ShopInstantNetwork = ShopInstantDefaultNetwork()) {
        self.network = network
    }
    
    func getTransactions() async throws -> TransactionsResponse {
        try await network.request(path: "/transactions", method: .get, body: nil, responseType: TransactionsResponse.self)
    }
    
    func postTransaction(with body: TransactionsViewModel.PresentModel) async throws -> Transaction {
        try await network.request(path: "/transactions", method: .post, body: body.toModel(), responseType: Transaction.self)
    }
}
