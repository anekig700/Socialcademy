//
//  CommentRow.swift
//  Socialcademy
//
//  Created by Kotya on 04/04/2025.
//

import SwiftUI

struct CommentRow: View {
    
    @State private var showConfirmationDialog = false
    @ObservedObject var viewModel: CommentRowViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(viewModel.author.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(viewModel.timeStamp.formatted())
                    .foregroundStyle(.gray)
                    .font(.caption)
            }
            Text(viewModel.content)
                .font(.headline)
                .fontWeight(.regular)
        }
        .padding(5)
        .swipeActions {
            if viewModel.canDeleteComment {
                Button {
                    showConfirmationDialog = true
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .tint(.red)
            }
        }
        .confirmationDialog("Are you sure you want to delete this comment?", isPresented: $showConfirmationDialog, titleVisibility: .visible) {
            Button("Delete", role: .destructive, action: {
                viewModel.deleteComment()
            })
        }
        
    }
}

#Preview {
    CommentRow(viewModel: CommentRowViewModel(comment: Comment.testComment, deleteAction: {}))
}
