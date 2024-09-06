//
//  File.swift
//  
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation
import Fluent
import Vapor

struct OffersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let offers = routes.grouped("offers")
        
        offers.get(use: self.index)
        offers.post(use: self.create)
        offers.group(":offerID") { offer in
            offer.delete(use: self.delete)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [OfferDTO] {
        try await Offer.query(on: req.db).all().map { $0.toDTO() }
    }
    
    @Sendable
    func create(req: Request) async throws -> OfferDTO {
        let offer = try req.content.decode(OfferDTO.self).toModel()
        
        try await offer.save(on: req.db)
        return offer.toDTO()
    }
    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let offer = try await Offer.find(req.parameters.get("offerID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await offer.delete(on: req.db)
        return .noContent
    }
}
