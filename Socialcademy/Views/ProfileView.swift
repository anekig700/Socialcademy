//
//  ProfileView.swift
//  Socialcademy
//
//  Created by Kotya on 31/03/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    var body: some View {
        Button("Sign Out", action: {
            try! Auth.auth().signOut()
        })
    }
}

#Preview {
    ProfileView()
}
