//
//  ShopInstantDefaultNetwork.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 06/09/24.
//

import Foundation

final class ShopInstantDefaultNetwork: ShopInstantNetwork {
    
    private let baseUrl = "http://localhost:8080"
    func request<T: Codable>(path: String, method: HTTPMethod, body: Encodable? = nil, responseType: T.Type) async throws -> T {
        var request = URLRequest(url: URL(string: baseUrl + path) ?? NSURL() as URL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60.0
        let session = URLSession(configuration: config)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
