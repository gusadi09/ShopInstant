//
//  File.swift
//  
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation
import Fluent
import Vapor

struct TransactionController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let trxs = routes.grouped("transactions")
        
        trxs.get(use: self.index)
        trxs.post(use: self.create)
        trxs.group(":transactionID") { trx in
            trx.delete(use: self.delete)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [TransactionDTO] {
        try await Transaction.query(on: req.db).all().map { $0.toDTO() }
    }
    
    @Sendable
    func create(req: Request) async throws -> TransactionDTO {
        let trx = try req.content.decode(TransactionDTO.self).toModel()
        
        try await trx.save(on: req.db)
        return trx.toDTO()
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let trx = try await Transaction.find(req.parameters.get("transactionID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await trx.delete(on: req.db)
        return .noContent
    }
}
