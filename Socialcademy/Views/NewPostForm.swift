//
//  NewPostForm.swift
//  Socialcademy
//
//  Created by Kotya on 20/03/2025.
//

import SwiftUI

struct NewPostForm: View {
    
    typealias CreateAction = (Post) -> Void
    
    let createAction: CreateAction
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var post = Post(title: "", content: "", authorName: "")
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $post.title)
                    TextField("Author Name", text: $post.authorName)
                }
                Section("Content") {
                    TextEditor(text: $post.content)
                        .multilineTextAlignment(.leading)
                }
                Button(action: createPost) {
                    Text("Create Post")
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .padding()
                .listRowBackground(Color.accentColor)
            }
            .onSubmit(createPost)
            .navigationBarTitle("New Post")
        }
    }
    
    private func createPost() {
        createAction(post)
        dismiss()
    }
}

#Preview {
    NewPostForm(createAction: { _ in })
}
