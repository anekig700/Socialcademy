//
//  PostsList.swift
//  Socialcademy
//
//  Created by Kotya on 19/03/2025.
//

import SwiftUI

struct PostsList: View {
    
    private var posts = [Post.testPost]
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(posts) { post in
                if searchText.isEmpty || post.contains(searchText) {
                    PostRow(post: post)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Posts")
        }
    }
}

#Preview {
    PostsList()
}
