//
//  AuthenticationService.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 09.06.2023.
//

import Foundation
import OSLog

enum AuthenticationState: CustomStringConvertible {
    case initializing, notAuthenticated, authenticating, authenticated

    var description: String {
        switch self {
            case .initializing: "Initializing…"
            case .notAuthenticated: "Not authenticated"
            case .authenticating: "Authenticating…"
            case .authenticated: "Authenticated"
        }
    }
}

/// Service that controls current authentication status
final class AuthenticationService: ApplicationService {

    // MARK: - Properties -

    @Published var authenticationState: AuthenticationState = .notAuthenticated {
        didSet {
            self.logger.log("Authentication state changed to \(self.authenticationState)")
        }
    }

    private let logger: Logger = .init(reporterType: AuthenticationService.self)

    // MARK: - Public API -

    func load() async throws {
        self.logger.info("Service loaded")
    }

    func start() async throws {
        self.logger.info("Service started")
    }

    func stop() async {
        self.logger.info("Service stopped")
    }

}
