//
//  DatabaseService.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 26.02.2023.
//

import Foundation
import CoreData

final class DatabaseService: AppService {

    private let databaseContainer: NSPersistentCloudKitContainer

    init(name: String) {
        self.databaseContainer = .init(name: name)
    }

    func load() async throws {
        try await self.databaseContainer.loadPersistentStores()
    }

    func start() async throws {}

    func stop() async {}

}
