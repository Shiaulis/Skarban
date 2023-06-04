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

    var viewController: UIViewController
    var rootViewController: UIViewController?
    private let authService: AuthenticationService

    // MARK: - Init

    init(globalContext: GlobalContext) {
        self.authService = globalContext.authService
        let viewModel = LoginViewModel(authService: globalContext.authService)
        let view = LoginView(viewModel: viewModel)
        self.viewController = UIHostingController(rootView: view)
    }

    func start() {
        self.rootViewController?.present(self.viewController, animated: true)
    }

    func stop() {}

    
}
