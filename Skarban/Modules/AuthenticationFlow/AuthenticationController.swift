//
//  AuthenticationController.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import OSLog
import AuthenticationServices

/// Module that provides possibility to register new account or login into existing one.
protocol AuthenticationController: ModuleController {
    func login(email: String, password: String) async throws
    func signUp(email:String, password: String) async
    func handleLogin(_ result: Result<ASAuthorization, Error>)
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

    func login(email: String, password: String) async throws {
        let session = try await self.networkClient.startAccountSession(email: email, password: password)
        try await self.secureDatabaseClient.store(session, forKey: .accountSession)
         assertionFailure()
    }

    func signUp(email:String, password: String) async {
        do {
            let accountUser = try await self.networkClient.createAccount(email: email, password: password)
            assertionFailure()
        }
        catch {
            assertionFailure()
        }
    }

    func handleLogin(_ result: Result<ASAuthorization, Error>) {
        switch result {
            case .success(let authorization):
                handle(authorization)
            case .failure(let error):
                handleLoginError(error)
        }
    }

    // MARK: - Private API -

    private func handle(_ authorization: ASAuthorization) {
        /*
         switch authorization.credential {
             case let appleIDCredential as ASAuthorizationAppleIDCredential:
                 let email = appleIDCredential.email
                 let firstName = appleIDCredential.fullName?.givenName
                 let lastName = appleIDCredential.fullName?.familyName
                 let userID = appleIDCredential.user

                 Task {
                     try! await self.networkClient.createOAuthSession()
                 }
             default:
                 assertionFailure()
         }
         */
    }

    private func handleLoginError(_ error: Error) {
        assertionFailure()
    }

}

final class InMemoryAuthenticationController: AuthenticationController {

    func start() {}
    func login(email: String, password: String) async {}
    func signUp(email: String, password: String) async {}
    func handleLogin(_ result: Result<ASAuthorization, Error>) {}
    func stop() {}

}
