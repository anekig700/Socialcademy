//
//  CommentsList.swift
//  Socialcademy
//
//  Created by Kotya on 04/04/2025.
//

import SwiftUI

struct CommentsList: View {
    
    @StateObject var viewModel: CommentsViewModel
    
    var body: some View {
        Group {
            switch viewModel.comments {
            case .loading:
                ProgressView()
                    .onAppear {
                        viewModel.fetchComments()
                    }
            case .error(let error):
                EmptyListView(
                    title: "Cannot Load Comments",
                    message: error.localizedDescription,
                    retryAction: {
                        viewModel.fetchComments()
                    }
                )
            case .empty:
                EmptyListView(
                    title: "No Comments",
                    message: "Be the first to leave a comment."
                )
            case .loaded(let comments):
                List(comments) { comment in
                    CommentRow(comment: comment)
                }
                .animation(.default, value: comments)
            }
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG
private struct ListPreview: View {
    let state: Loadable<[Comment]>
    
    var body: some View {
        NavigationView {
            CommentsList(viewModel: CommentsViewModel(commentsRepository: CommentsRepositoryStub(state: state)))
        }
    }
    
}

#Preview {
    ListPreview(state: .loaded([Comment.testComment]))
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
