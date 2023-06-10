//
//  DatabaseService.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 26.02.2023.
//

import Foundation
import CoreData
import OSLog

final class DatabaseService: ApplicationService {

    private let databaseContainer: NSPersistentCloudKitContainer
    private let logger: Logger = .init(reporterType: DatabaseService.self)

    init(name: String) {
        self.databaseContainer = .init(name: name)
    }

    func load() async throws {
        try await self.databaseContainer.loadPersistentStores()
        self.logger.info("Service loaded")
    }

    func start() async throws {
        self.logger.info("Service started")
    }

    func stop() async {
        self.logger.info("Service stopped")
    }

}
