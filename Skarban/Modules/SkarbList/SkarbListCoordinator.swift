//
//  SkarbListCoordinator.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 26.02.2023.
//

import UIKit
import SwiftUI
import Combine

@MainActor
final class SkarbListCoordinator: Coordinator {

    // MARK: - Properties -

    var rootViewController: UIViewController!
    private (set) var skarbListViewController: UIViewController!
    private let globalContext: GlobalContext
    private var disposables: Set<AnyCancellable> = []
    private var authenticationCoordinator: AuthenticationCoordinator?
    private let controller: SkarbListController

    // MARK: - Init -

    init(globalContext: GlobalContext) {
        self.controller = .init(globalContext: globalContext)
        self.globalContext = globalContext

        configureController()
        setSkarbListViewController()
    }

    // MARK: - Public Interface

    func start() {
        self.controller.start()
    }

    func stop() {
        self.controller.stop()
    }

    // MARK: - Private Interface

    private func setSkarbListViewController() {
        self.skarbListViewController = UIHostingController(rootView: SkarbListView())
    }

    private func showAuthenticationFlow() {
        // doesn't make any sense to start auth coordinator if another one is active
        guard self.authenticationCoordinator == nil else { return }
        let authCoordinator = AuthenticationCoordinator(globalContext: self.globalContext)
        authCoordinator.rootViewController = self.skarbListViewController
        authCoordinator.completion = { [weak self] action in
            guard let self else { return }
            switch action {
                case .dismiss:
                    self.authenticationCoordinator?.stop()
                    self.authenticationCoordinator = nil
            }
        }
        self.authenticationCoordinator = authCoordinator
        authCoordinator.start()
    }

    private func dismissAuthenticationFlow() {
        // nothing to dismiss 🤷🏾
        guard let authenticationCoordinator else { return }

        authenticationCoordinator.stop()
    }

    private func configureController() {
        self.controller.completion = { [weak self] action in
            guard let self else { return }
            switch action {
                case .showAuthenticationFlow: self.showAuthenticationFlow()
                case .dismissAuthenticationFlow: self.dismissAuthenticationFlow()
            }
        }
    }

}
