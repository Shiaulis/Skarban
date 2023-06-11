//
//  SkarbListController.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 10.06.2023.
//

import Foundation
import Combine
import OSLog

/// Controller object for skarb list
final class SkarbListController: ModuleController {

    enum CompletionAction {
        case showAuthenticationFlow
        case dismissAuthenticationFlow
    }

    // MARK: - Properties -
    var completion: ((CompletionAction) -> Void)!

    private let globalContext: GlobalContext
    private var disposables: Set<AnyCancellable> = []
    private let logger: Logger = .init(reporterType: SkarbListController.self)

    // MARK: - Init -
    init(globalContext: GlobalContext) {
        self.globalContext = globalContext
    }

    // MARK: - Public API -

    func start() {
        self.logger.info("Skarb List Controller started")

        subscribeOnAuthenticationStates()
    }

    func stop() {
        self.disposables = []
        self.logger.info("Skarb List Controller stopped")
    }

    // MARK: - Private API -

    private func subscribeOnAuthenticationStates() {
        self.globalContext.authenticationService.$authenticationState
            .handleEvents(receiveSubscription: { _ in
                self.logger.info("Subscribed on authentication states")
            })
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                    case .notAuthenticated: self.completion(.showAuthenticationFlow)
                    case .authenticated: self.completion(.dismissAuthenticationFlow)
                    default: break
                }
            }
            .store(in: &disposables)
    }

}
