//
//  AuthenticationService.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import os.log

final class AuthenticationService: AppService {

    enum AuthenticationState {
        case initializing, notAuthenticated, authenticating, authenticated
    }

    @Published var state: AuthenticationState = .notAuthenticated

    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.shiaulis.Skarban", category: "AuthenticationService")

    // MARK: - AppService API

    func load() async throws {}

    func start() async throws {}

    func stop() async {}

    // MARK: - Public API -

    func login(email: String, password: String) {
        self.logger.debug("Login not implemented yet. Login: \(email), password: \(password)")
    }

}
