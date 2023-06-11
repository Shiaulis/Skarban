//
//  GlobalContext.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import OSLog

/// Global object that should be passed across modules
final class GlobalContext {

    // MARK: - Properties -

    let databaseService: DatabaseService
    let appwriteService: AppwriteService
    let authenticationService: AuthenticationService

    let networkClient: NetworkClient
    let secureDatabaseClient: SecureDatabaseClient

    private var services: [ApplicationService]  {
        [
            self.databaseService,
            self.appwriteService,
            self.authenticationService,
        ]
    }

    private let logger: Logger = .init(reporterType: GlobalContext.self)

    // MARK: - Init -

    init(applicationName: String) {
        self.databaseService = .init(name: applicationName)
        let appwriteService = AppwriteService()
        self.appwriteService = appwriteService
        self.secureDatabaseClient = KeychainSecureDatabaseClient()
        self.authenticationService = AuthenticationService(secureDatabaseClient: self.secureDatabaseClient)

        self.networkClient = AppwriteNetworkClient()
        self.networkClient.authenticationMonitorDelegate = self.authenticationService

        self.logger.info("Global context initialized")
    }

    // MARK: - Public interface -

    func start() {
        startApplicationServices()
    }

    // MARK: - Private interface -

    private func startApplicationServices() {
        Task(priority: .userInitiated) {
            do {
                for service in self.services {
                    try await service.load()
                    try await service.start()
                }

                self.logger.info("Application services started")
            }
            catch {
                self.logger.fault("Failed to start one of application services. Error: \(error.localizedDescription)")
                fatalError("Failed to start one of application services. Error: \(error.localizedDescription)")
            }
        }
    }

}
