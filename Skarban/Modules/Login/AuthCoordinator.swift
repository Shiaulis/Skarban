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

    var rootViewController: UIViewController?
    private let authService: AuthenticationService

    // MARK: - Init

    init(globalContext: GlobalContext) {
        self.authService = globalContext.authService
    }

    var viewController: UIViewController = UIHostingController(rootView: LoginView())

    func start() {
        self.rootViewController?.present(self.viewController, animated: true)
    }

    func stop() {}

    
}
