//
//  AuthenticationService.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation

final class AuthenticationService: AppService {

    enum AuthenticationState {
        case initializing, notAuthenticated, authenticating, authenticated
    }

    @Published var state: AuthenticationState = .notAuthenticated

    // MARK: - AppService API

    func load() async throws {}

    func start() async throws {}

    func stop() async {}

}
