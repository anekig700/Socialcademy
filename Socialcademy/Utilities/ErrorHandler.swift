//
//  ErrorHandler.swift
//  Socialcademy
//
//  Created by Kotya on 06/04/2025.
//

import Foundation

@MainActor
protocol ErrorHandler: AnyObject {
    var error: Error? { get set }
}

extension ErrorHandler {
    func withErrorHandlingTask(perform action: @escaping () async throws -> Void) {
        Task {
            do {
                try await action()
            }
            catch {
                print("[\(Self.self)] Error: \(error)")
                self.error = error
            }
        }
    }
}
