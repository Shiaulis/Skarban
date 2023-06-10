//
//  SignUpViewModel.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation

enum SignUpCompletionAction {
    case signUpCompleted
}

final class SignUpViewModel {

    // MARK: - Properties -

    var completion: ((SignUpCompletionAction) -> Void)!
    private let authenticationController: AuthenticationController

    // MARK: - Init -

    init(authenticationController: AuthenticationController) {
        self.authenticationController = authenticationController
    }

    // MARK: - Public interface -

    func signUp(email: String, password: String) {
        Task(priority: .userInitiated) {
            await self.authenticationController.signUp(email: email, password: password)
        }
    }

}
