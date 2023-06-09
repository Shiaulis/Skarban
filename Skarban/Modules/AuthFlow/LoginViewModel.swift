//
//  LoginViewModel.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation

enum LoginCompletionAction {
    case signUp
}

final class LoginViewModel {

    // MARK: - Properties -

    var completion: ((LoginCompletionAction) -> Void)!
    private let authService: AuthenticationController

    // MARK: - Init -

    init(authService: AuthenticationController) {
        self.authService = authService
    }

    // MARK: - Public interface -

    func login(using email: String, password: String) {
        Task(priority: .userInitiated) {
            await self.authService.login(email: email, password: password)
        }
    }

    func signUp() {
        self.completion(.signUp)
    }
    
}
