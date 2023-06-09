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
    private var authCoordinator: AuthCoordinator?

    // MARK: - Init -

    init(globalContext: GlobalContext) {
        self.globalContext = globalContext
        setSkarbListViewController()
    }

    // MARK: - Public Interface

    func start() {
        bindAuthState()
    }

    func stop() {}

    // MARK: - Private Interface

    private func bindAuthState() {
        self.globalContext.authService.$state
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                    case .notAuthenticated: self.showAuthFlow()
                    default: break
                }
            }
            .store(in: &disposables)
    }

    private func setSkarbListViewController() {
        self.skarbListViewController = UIHostingController(rootView: SkarbListView())
    }

    private func showAuthFlow() {
        // doesn't make any sense to start auth coordinator if another one is active
        guard self.authCoordinator == nil else { return }
        let authCoordinator = AuthCoordinator(globalContext: self.globalContext)
        authCoordinator.rootViewController = self.skarbListViewController
        self.authCoordinator = authCoordinator
        authCoordinator.start()
    }

}
