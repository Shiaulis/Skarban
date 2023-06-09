//
//  AuthCoordinator.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import UIKit
import SwiftUI

final class AuthCoordinator: Coordinator {

    // MARK: - Properties -

    var rootViewController: UIViewController!
    private var loginViewController: UIViewController!
    private var signUpViewController: UIViewController!

    private let authController: AuthenticationController

    // MARK: - Init

    init(globalContext: GlobalContext) {
        let accountNetworkClient = AppwriteAccountNetworkClient(appwriteService: globalContext.appwriteService)
        let accountDatabaseClient = KeychainAccountDatabaseClient()
        self.authController = NetworkAuthenticationController(
            accountNetworkClient: accountNetworkClient,
            accountDatabaseClient: accountDatabaseClient
        )
    }

    // MARK: - Coordinator interface -

    func start() {
        setLoginViewController()
        presentLogin()
    }

    func stop() {}

    // MARK: - Private interface

    private func setLoginViewController() {
        guard self.loginViewController == nil else {
            assertionFailure("Why we are trying to setup new login screen while another one is already presented?")
            return
        }

        let viewModel = LoginViewModel(authService: self.authController)
        viewModel.completion = { [weak self] action in
            guard let self else { return }
            switch action {
                case .signUp:
                    setSignUpViewController()
                    presentSignUp()
            }
        }

        let view = LoginView(viewModel: viewModel)
        self.loginViewController = UIHostingController(rootView: view)
    }

    private func setSignUpViewController() {
        guard self.signUpViewController == nil else {
            assertionFailure("Why we are trying to setup new sign up screen while another one is already presented?")
            return
        }

        let viewModel = SignUpViewModel(authService: self.authController)
        viewModel.completion = { [weak self] action in
            guard self != nil else { return }
            switch action {
                case .signUpCompleted:
                    assertionFailure("Should be implemented")
            }
        }

        let view = SignUpView(viewModel: viewModel)
        self.signUpViewController = UIHostingController(rootView: view)
    }

    private func presentLogin() {
        self.rootViewController.present(self.loginViewController, animated: true)
    }

    private func presentSignUp() {
        self.loginViewController.present(self.signUpViewController, animated: true)
    }

    
}
