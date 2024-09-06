//
//  FirestoreDefaultDataSource.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 05/09/24.
//

import Foundation
import FirebaseFirestore

final class FirestoreDefaultDataSource: FirestoreDataSource {
   
    private var db = Firestore.firestore()
    
    func fetch(from collection: String) async throws -> [[String : Any]] {
        let snapshot = try await db.collection(collection).getDocuments()
        
        print(snapshot.documents)
        
        let data = snapshot.documents.compactMap { document in
            let data = document.data()
            return data
        }
        
        print(data)
        
        return data
    }
    
    func add(from collection: String, with value: [String: Any]) async throws {
        try await db.collection(collection).addDocument(data: value)
    }
    
    func delete(from collection: String, with value: String) async throws {
        try await db.collection(collection).document(value).delete()
    }
}
