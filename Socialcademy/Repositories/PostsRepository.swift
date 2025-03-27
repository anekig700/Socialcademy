//
//  PostsRepository.swift
//  Socialcademy
//
//  Created by Kotya on 23/03/2025.
//

import Foundation
import FirebaseFirestore

protocol PostsRepositoryProtocol {
    func fetchPosts() async throws -> [Post]
    func create(_ post: Post) async throws
    func delete(_ post: Post) async throws
}

#if DEBUG
struct PostsRepositoryStub: PostsRepositoryProtocol {
    
    let state: Loadable<[Post]>
    
    func fetchPosts() async throws -> [Post] {
        return try await state.simulate()
    }
    
    func create(_ post: Post) async throws {}
    
    func delete(_ post: Post) async throws {}
}
#endif

struct PostsRepository: PostsRepositoryProtocol {
    
    let postsReference = Firestore.firestore().collection("posts")
    
    func create(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.setData(from: post)
    }
    
    func fetchPosts() async throws -> [Post] {
        let snapshot = try await postsReference
            .order(by: "timeStamp", descending: true)
            .getDocuments()
        return snapshot.documents.compactMap { document in
            try! document.data(as: Post.self)
        }
    }
    
    func delete(_ post: Post) async throws {
        let document = postsReference.document(post.id.uuidString)
        try await document.delete()
    }
}

private extension DocumentReference {
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
