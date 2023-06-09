//
//  GlobalContext.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation

/// Global object that should be passed across coordinators
final class GlobalContext {

    // MARK: - Properties -

    let databaseService: DatabaseService
    let appwriteService: AppwriteService

    private var services: [AppService]  {
        [
            self.databaseService,
            self.appwriteService,
        ]
    }

    // MARK: - Init -

    init(applicationName: String) {
        self.databaseService = .init(name: applicationName)
        let appwriteService = AppwriteService()
        self.appwriteService = appwriteService
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
            }
            catch {
                // FIXME: Show error
                assertionFailure()
            }
        }
    }

}
