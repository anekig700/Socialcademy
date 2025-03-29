//
//  PostsList.swift
//  Socialcademy
//
//  Created by Kotya on 19/03/2025.
//

import SwiftUI

struct PostsList: View {
    
    @StateObject var viewModel = PostsViewModel()
    
    @State private var searchText = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.posts {
                case .loading:
                    ProgressView()
                case let .error(error):
                    EmptyListView(
                        title: "Cannot Load Posts",
                        message: error.localizedDescription,
                        retryAction: {
                            viewModel.fetchPosts()
                        }
                    )
                case .empty:
                    EmptyListView(
                        title: "No Posts",
                        message: "There aren’t any posts yet."
                    )
                case let .loaded(posts):
                    List(posts) { post in
                        if searchText.isEmpty || post.contains(searchText) {
                            PostRow(viewModel: viewModel.makePostRowViemModel(for: post))
                        }
                    }
                    .animation(.default, value: posts)
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
        .onAppear {
            viewModel.fetchPosts()
        }
        .sheet(isPresented: $showNewPostForm) {
            NewPostForm(createAction: viewModel.makeCreateAction())
        }
    }
}

#if DEBUG

@MainActor
private struct ListPreview: View {
    let state: Loadable<[Post]>
    
    var body: some View {
        let postsRepository = PostsRepositoryStub(state: state)
        let viewModel = PostsViewModel(postsRepository: postsRepository)
        PostsList(viewModel: viewModel)
    }
    
}

#Preview {
    ListPreview(state: .loaded([Post.testPost]))
}

#Preview {
    ListPreview(state: .error)
}

#Preview {
    ListPreview(state: .loading)
}

#Preview {
    ListPreview(state: .empty)
}
#endif
