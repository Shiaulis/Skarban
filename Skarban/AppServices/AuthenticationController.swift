//
//  AuthenticationController.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import Combine
import os.log

protocol AuthenticationController {

    func login(email: String, password: String) async
    func signUp(email:String, password: String) async

}

final class NetworkAuthenticationController: AuthenticationController {

    // MARK: - Properties -

    private let accountNetworkClient: AccountNetworkClient
    private let accountDatabaseClient: AccountDatabaseClient
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.shiaulis.Skarban", category: "AuthenticationService")

    // MARK: - Init -

    init(accountNetworkClient: AccountNetworkClient, accountDatabaseClient: AccountDatabaseClient) {
        self.accountNetworkClient = accountNetworkClient
        self.accountDatabaseClient = accountDatabaseClient
    }

    // MARK: - Public API -

    func login(email: String, password: String) async {
        self.logger.debug("Login not implemented yet. Login: \(email), password: \(password)")
    }

    func signUp(email:String, password: String) async {
        do {
            let accountUser = try await self.accountNetworkClient.createAccount(email: email, password: password)
            try await self.accountDatabaseClient.store(accountUser: accountUser)
        }
        catch {
            assertionFailure()
        }
    }

}
