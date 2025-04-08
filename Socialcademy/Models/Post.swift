//
//  Post.swift
//  Socialcademy
//
//  Created by Kotya on 19/03/2025.
//

import Foundation

struct Post: Identifiable, Equatable {
    var title: String
    var content: String
    var author: User
    var isFavorite = false
    var timeStamp = Date()
    var id = UUID()
    var imageURL: URL?
    
    func contains(_ string: String) -> Bool {
        let properties = [title, content, author.name].map { $0.lowercased() }
        let query = string.lowercased()
        let matches = properties.filter { $0.contains(query) }
        return !matches.isEmpty
    }
}

extension Post {
    static let testPost = Post(
        title: "Lorem ipsum",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        author: User.testUser
    )
}

extension Post: Codable {
    enum CodingKeys: String, CodingKey {
        case title, content, author, timeStamp, id, imageURL
    }
}
