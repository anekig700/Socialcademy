//
//  CommentRow.swift
//  Socialcademy
//
//  Created by Kotya on 04/04/2025.
//

import SwiftUI

struct CommentRow: View {
    
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(comment.author.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(comment.timeStamp.formatted())
                    .foregroundStyle(.gray)
                    .font(.caption)
            }
            Text(comment.content)
                .font(.headline)
                .fontWeight(.regular)
        }
        .padding(5)
    }
}

#Preview {
    CommentRow(comment: Comment.testComment)
}
