//
//  AuthenticationCoordinator.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import UIKit
import SwiftUI

final class AuthenticationCoordinator: Coordinator {

    enum CompletionAction {
        case dismiss
    }

    // MARK: - Properties -

    var rootViewController: UIViewController!
    var completion: ((CompletionAction) -> Void)!

    private let controller: AuthenticationController
    private let loginViewModel: LoginViewModel
    private let loginViewController: UIViewController
    private var signUpViewController: UIViewController!

    // MARK: - Init

    init(globalContext: GlobalContext) {
        let controller = NetworkAuthenticationController(
            networkClient: globalContext.networkClient,
            secureDatabaseClient: globalContext.secureDatabaseClient
        )
        let loginViewModel = LoginViewModel(authenticationController: controller)
        let loginView = LoginView(viewModel: loginViewModel)

        self.controller = controller
        self.loginViewModel = loginViewModel
        self.loginViewController = UIHostingController(rootView: loginView)
    }

    // MARK: - Coordinator interface -

    func start() {
        self.controller.start()
        configureLoginViewModel()
        showLogin()
    }

    func stop() {
        self.controller.stop()
        self.loginViewModel.stop()
    }

    // MARK: - Private interface

    private func setSignUpViewController() {
        guard self.signUpViewController == nil else {
            assertionFailure("Why we are trying to setup new sign up screen while another one is already presented?")
            return
        }

        let viewModel = SignUpViewModel(authenticationController: self.controller)
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

    private func showLogin() {
        self.rootViewController.present(self.loginViewController, animated: true)
    }

    private func showSignUp() {
        self.loginViewController.present(self.signUpViewController, animated: true)
    }

    private func configureLoginViewModel() {
        self.loginViewModel.completion = { [weak self] action in
            guard let self else { return }
            switch action {
                case .signUp:
                    setSignUpViewController()
                    showSignUp()
                case .dismiss:
                    self.completion(.dismiss)
            }
        }
    }

    
}
