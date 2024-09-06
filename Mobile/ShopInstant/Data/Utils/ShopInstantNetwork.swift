//
//  ShopInstantNetwok.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation

protocol ShopInstantNetwork {
    func request<T: Codable>(path: String, method: HTTPMethod, body: Encodable?, responseType: T.Type) async throws -> T
}
