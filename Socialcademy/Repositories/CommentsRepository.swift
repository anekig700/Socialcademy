//
//  CommentsRepository.swift
//  Socialcademy
//
//  Created by Kotya on 04/04/2025.
//

import Foundation
import FirebaseFirestore

protocol CommentsRepositoryProtocol {
    
    var user: User { get }
    var post: Post { get }
    
    func fetchComments() async throws -> [Comment]
    func create(_ comment: Comment) async throws
    func delete(_ comment: Comment) async throws
}

extension CommentsRepositoryProtocol {
    func canDelete(_ comment: Comment) -> Bool {
        [comment.author.id, post.author.id].contains(user.id)
    }
}

#if DEBUG
struct CommentsRepositoryStub: CommentsRepositoryProtocol {
    
    let user = User.testUser
    let post = Post.testPost
    let state: Loadable<[Comment]>
    
    func fetchComments() async throws -> [Comment] {
        return try await state.simulate()
    }
    
    func create(_ comment: Comment) async throws {}
    
    func delete(_ comment: Comment) async throws {}
}
#endif

struct CommentsRepository: CommentsRepositoryProtocol {
    
    let user: User
    let post: Post
    
    private var commentsReference: CollectionReference {
        let postsReference = Firestore.firestore().collection("posts_v2")
        let document = postsReference.document(post.id.uuidString)
        return document.collection("comments")
    }
    
    func fetchComments() async throws -> [Comment] {
        return try await commentsReference
            .order(by: "timeStamp", descending: true)
            .getDocuments(as: Comment.self)
    }
    
    func create(_ comment: Comment) async throws {
        let document = commentsReference.document(comment.id.uuidString)
        try await document.setData(from: comment)
    }
    
    func delete(_ comment: Comment) async throws {
        precondition(canDelete(comment))
        let document = commentsReference.document(comment.id.uuidString)
        try await document.delete()
    }
}
