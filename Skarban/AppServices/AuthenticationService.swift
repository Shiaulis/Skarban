//
//  AuthenticationService.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 09.06.2023.
//

import Foundation
import Combine
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

    @Published var authenticationState: AuthenticationState = .initializing

    @Published private var accountSession: AccountSession?

    private let secureDatabaseClient: SecureDatabaseClient
    private var disposables: Set<AnyCancellable> = []
    private let logger: Logger = .init(reporterType: AuthenticationService.self)

    // MARK: - Init -
    init(secureDatabaseClient: SecureDatabaseClient) {
        self.secureDatabaseClient = secureDatabaseClient
    }

    // MARK: - Public API -

    func load() async throws {
        self.logger.info("Service loaded")
        self.accountSession = try await self.secureDatabaseClient.getObject(forKey: .accountSession)
    }

    func start() async throws {
        self.logger.info("Authentication service started")
        bindSession()
    }

    func stop() async {
        self.disposables = []
        self.logger.info("Authentication service stopped")
    }

    // MARK: - Private API -

    private func bindSession() {
        self.$accountSession
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.logger.info("Subscribed for account session changes")
            })
            .sink { [weak self] accountSession in
                guard let self else { return }
                store(accountSession)
                updateAuthenticationState(for: accountSession)
            }
            .store(in: &self.disposables)
    }

    private func store(_ accountSession: AccountSession?) {
        Task(priority: .userInitiated) {
            do {
                guard accountSession != self.accountSession else { return }
                try await self.secureDatabaseClient.store(accountSession, forKey: .accountSession)

                if accountSession != nil {
                    self.logger.info("New account session stored in secure database")
                }
                else {
                    self.logger.info("Account session removed from secure database")
                }
            }
            catch {
                self.logger.error("Failed to store account session to secure database")
                // FIXME: Make a proper error handling here instead
                assertionFailure()
            }
        }
    }

    private func updateAuthenticationState(for accountSession: AccountSession?) {
        if accountSession != nil {
            self.authenticationState = .authenticated
            self.logger.log("Account session detected. Authentication state changed to \"\(self.authenticationState)\"")
        }
        else {
            self.authenticationState = .notAuthenticated
            self.logger.log("No account session found. Authentication state changed to \"\(self.authenticationState)\"")
        }
    }

}

extension AuthenticationService: AuthenticationMonitorDelegate {

    func accountSessionUpdated(_ accountSession: AccountSession) {
        self.accountSession = accountSession
        self.logger.info("Account Session updated")
    }

    func authenticationStarted() {
        self.accountSession = nil
        self.authenticationState = .authenticating
    }

}
