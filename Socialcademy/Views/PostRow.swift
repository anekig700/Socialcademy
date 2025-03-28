//
//  PostRow.swift
//  Socialcademy
//
//  Created by Kotya on 19/03/2025.
//

import SwiftUI

struct PostRow: View {
    
    typealias Action = () async throws -> Void
    
    let post: Post
    let deleteAction: Action
    let favoriteAction: Action
    
    @State private var showConfirmationDialog = false
    @State private var error: Error?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(post.authorName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text(post.timeStamp.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
            }
            .foregroundStyle(.gray)
            Text(post.title)
                .font(.title3)
                .fontWeight(.semibold)
            Text(post.content)
            HStack {
                FavoriteButton(isFavorite: post.isFavorite, action: favoritePost)
                Spacer()
                Button(role: .destructive, action: {
                    showConfirmationDialog = true
                }) {
                    Label("Delete", systemImage: "trash")
                }
            }
            .labelStyle(.iconOnly)
            .buttonStyle(.borderless)
        }
        .padding(.vertical)
        .confirmationDialog("Are you sure you want to delete this post?", isPresented: $showConfirmationDialog, titleVisibility: .visible, actions: {
            Button("Delete", role: .destructive, action: deletePost)
        })
        .alert("Cannot Delete Post", error: $error)
    }
    
    private func deletePost() {
        Task {
            do {
                try await deleteAction()
            }
            catch {
                print("[PostRow] Cannot delete post: \(error)")
                self.error = error
            }
        }
    }
    
    private func favoritePost() {
        Task {
            do {
                try await favoriteAction()
            }
            catch {
                print("[PostRow] Cannot favorite post: \(error)")
                self.error = error
            }
        }
    }
}

private extension PostRow {
    struct FavoriteButton: View {
        let isFavorite: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action, label: {
                if isFavorite {
                    Label("Remove from Favorites", systemImage: "heart.fill")
                } else {
                    Label("Add to Favorites", systemImage: "heart")
                }
            })
            .foregroundStyle(isFavorite ? .red : .gray)
            .animation(.default, value: isFavorite)
        }
    }
}

#Preview {
    List {
        PostRow(post: Post.testPost, deleteAction: {}, favoriteAction: {})
    }
}
