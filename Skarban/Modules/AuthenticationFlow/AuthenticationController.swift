//
//  AuthenticationController.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import OSLog

/// Module that provides possibility to register new account or login into existing one.
protocol AuthenticationController: ModuleController {

    func login(email: String, password: String) async
    func signUp(email:String, password: String) async

}

final class NetworkAuthenticationController: AuthenticationController {

    // MARK: - Properties -

    private let networkClient: NetworkClient
    private let secureDatabaseClient: SecureDatabaseClient
    private let logger: Logger = .init(reporterType: NetworkAuthenticationController.self)

    // MARK: - Init -

    init(networkClient: NetworkClient, secureDatabaseClient: SecureDatabaseClient) {
        self.networkClient = networkClient
        self.secureDatabaseClient = secureDatabaseClient
    }

    // MARK: - Public API -

    func start() {
        self.logger.info("Network Authentication Controller started")
    }

    func stop() {
        self.logger.info("Network Authentication Controller stopped")
    }

    func login(email: String, password: String) async {
        self.logger.debug("Login not implemented yet. Login: \(email), password: \(password)")
    }

    func signUp(email:String, password: String) async {
        do {
            let accountUser = try await self.networkClient.createAccount(email: email, password: password)
            try await self.secureDatabaseClient.store(accountUser: accountUser)
        }
        catch {
            assertionFailure()
        }
    }

}

final class InMemoryAuthenticationController: AuthenticationController {

    func start() {}
    func login(email: String, password: String) async {}
    func signUp(email: String, password: String) async {}
    func stop() {}

}
