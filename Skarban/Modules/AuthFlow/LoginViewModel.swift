//
//  LoginViewModel.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation

final class LoginViewModel {

    // MARK: - Properties -

    private let authService: AuthenticationService

    // MARK: - Init -

    init(authService: AuthenticationService) {
        self.authService = authService
    }

    func login(using email: String, password: String) {
        self.authService.login(email: email, password: password)
    }
}
