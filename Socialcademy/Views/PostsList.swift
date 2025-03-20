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
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationStack {
            List(posts) { post in
                if searchText.isEmpty || post.contains(searchText) {
                    PostRow(post: post)
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Posts")
            .toolbar {
                Button {
                    showNewPostForm = true
                } label: {
                    Label("New Post", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showNewPostForm) {
            NewPostForm(createAction: { _ in })
        }
    }
}

#Preview {
    PostsList()
}
