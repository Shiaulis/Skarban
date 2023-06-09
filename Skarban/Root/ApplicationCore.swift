//
//  ApplicationCore.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 26.02.2023.
//

import Foundation
import UIKit
import Appwrite
import Combine

private let applicationName: String = "Skarban"

@MainActor
final class ApplicationCore {

    // MARK: - Properties -

    static private(set) var shared: ApplicationCore = .init()

    private var rootViewController: UIViewController!
    private let globalContext: GlobalContext
    private var rootSceneCoordinators: [Coordinator] = []


    // MARK: - Init

    init() {
        self.globalContext = .init(applicationName: applicationName)
        self.globalContext.start()
    }

    // MARK: - Public interface -

    func start(_ scene: UIScene, in window: UIWindow) {
        let skarbListCoordinator = SkarbListCoordinator(globalContext: self.globalContext)
        window.rootViewController = skarbListCoordinator.skarbListViewController
        rootSceneCoordinators.append(skarbListCoordinator)
        window.makeKeyAndVisible()
        skarbListCoordinator.start()
    }

    // MARK: - Private -

}
