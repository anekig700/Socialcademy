//
//  Firestore+Extensions.swift
//  Socialcademy
//
//  Created by Kotya on 04/04/2025.
//

import Foundation
import FirebaseFirestore

extension DocumentReference {
    func setData<T: Encodable>(from value: T) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            try! setData(from: value) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume()
            }
        }
    }
}

extension Query {
    func getDocuments<T: Decodable>(as type: T.Type) async throws -> [T] {
        let snapshot = try await getDocuments()
        return snapshot.documents.compactMap{ document in
            try! document.data(as: type)
        }
    }
}
