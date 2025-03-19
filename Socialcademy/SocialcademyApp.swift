//
//  SocialcademyApp.swift
//  Socialcademy
//
//  Created by Kotya on 19/03/2025.
//

import Firebase
import SwiftUI

@main
struct SocialcademyApp: App {
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            PostsList()
        }
    }
}
