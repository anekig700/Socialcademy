//
//  PostRowViewModel.swift
//  Socialcademy
//
//  Created by Kotya on 29/03/2025.
//

import Foundation

@MainActor
@dynamicMemberLookup
class PostRowViewModel: ObservableObject, ErrorHandler {
    
    typealias Action = () async throws -> Void
    
    @Published var post: Post
    @Published var error: Error?
    
    private let deleteAction: Action?
    private let favoriteAction: Action
    
    init(post: Post, deleteAction: Action?, favoriteAction: @escaping Action) {
        self.post = post
        self.deleteAction = deleteAction
        self.favoriteAction = favoriteAction
    }
    
    var canDeletePost: Bool { deleteAction != nil }
    
    func deletePost() {
        guard let deleteAction = deleteAction else {
            preconditionFailure("Cannot delete post: no delete action provided")
        }
        withErrorHandlingTask(perform: deleteAction)
    }
    
    func favoritePost() {
        withErrorHandlingTask(perform: favoriteAction)
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Post, T>) -> T {
        post[keyPath: keyPath]
    }
}
