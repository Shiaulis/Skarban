//
//  LoginViewModel.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import OSLog
import AuthenticationServices

enum LoginCompletionAction {
    case signUp
    case dismiss
}

final class LoginViewModel {

    // MARK: - Properties -

    static var requestScopes: [ASAuthorization.Scope] = [.fullName, .email]
    var completion: ((LoginCompletionAction) -> Void)!
    private let authenticationController: AuthenticationController
    private let logger: Logger = .init(reporterType: LoginViewModel.self)

    // MARK: - Init -

    init(authenticationController: AuthenticationController) {
        self.authenticationController = authenticationController
    }

    // MARK: - Public interface -

    func appear() {
        self.logger.info("Login View appeared")
    }

    func disappear() {
        self.logger.info("Login View disappeared")
        self.completion(.dismiss)
    }

    func login(using email: String, password: String) {
        Task(priority: .userInitiated) {
            do {
                try await self.authenticationController.login(email: email, password: password)
            }
            catch {
                assertionFailure()
            }
        }
    }

    func signUp() {
        self.completion(.signUp)
    }

    func handleSignInResult(with result: Result<ASAuthorization, Error>) {
        self.authenticationController.handleLogin(result)
    }

    func stop() {
        self.completion(.dismiss)
    }

}
