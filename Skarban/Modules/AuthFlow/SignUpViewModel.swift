//
//  SignUpViewModel.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import os.log

enum SignUpCompletionAction {
    case signUpCompleted
}

final class SignUpViewModel {

    // MARK: - Properties -

    var completion: ((SignUpCompletionAction) -> Void)!
    private let authService: AuthenticationController

    // MARK: - Init -

    init(authService: AuthenticationController) {
        self.authService = authService
    }

    // MARK: - Public interface -

    func signUp(email: String, password: String) {
        Task(priority: .userInitiated) {
            await self.authService.signUp(email: email, password: password)
        }
    }

}
