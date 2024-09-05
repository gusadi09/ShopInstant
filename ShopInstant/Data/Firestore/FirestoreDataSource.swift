//
//  FirestoreDataSource.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 05/09/24.
//

import Foundation

protocol FirestoreDataSource {
    func fetch(from collection: String) async throws -> [[String : Any]]
    func add(from collection: String, with value: [String: Any]) async throws
    func delete(from collection: String, with value: String) async throws
}
