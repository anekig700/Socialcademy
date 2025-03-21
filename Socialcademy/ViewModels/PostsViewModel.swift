//
//  PostsViewModel.swift
//  Socialcademy
//
//  Created by Kotya on 21/03/2025.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    
   @Published var posts = [Post.testPost]
    
    func makeCreateAction() -> NewPostForm.CreateAction {
        return { [weak self] post in
            self?.posts.insert(post, at: 0)
        }
    }
}
