//
//  Comment.swift
//  Socialcademy
//
//  Created by Kotya on 04/04/2025.
//

import Foundation

struct Comment: Identifiable, Equatable, Codable {
    var id = UUID()
    var content: String
    var author: User
    var timeStamp = Date()
}

extension Comment {
    static let testComment = Comment(content: "Lorem ipsum dolor set amet.", author: User.testUser)
}
