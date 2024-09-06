//
//  TransactionsRemoteDataSource.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import Foundation

protocol TransactionsRemoteDataSource {
    func getTransactions() async throws -> TransactionsResponse
    func postTransaction(with body: TransactionsViewModel.PresentModel) async throws -> Transaction
}
