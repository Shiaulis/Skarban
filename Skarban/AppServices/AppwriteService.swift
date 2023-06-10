//
//  AppwriteService.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import Appwrite
import OSLog

final class AppwriteService: ApplicationService {

    // MARK: - Properties -

    private var client: Client!
    private let logger: Logger = .init(reporterType: AppwriteService.self)

    // MARK: - AppService API

    func load() async throws {
        self.client = Appwrite.Client()
            .setEndpoint("https://cloud.appwrite.io/v1")
            .setProject("647bb78335f05ef274c5")
        self.logger.info("Service loaded")
    }


    func start() async throws {
        self.logger.info("Service started")
    }

    func stop() async {
        self.logger.info("Service stopped")
    }

    func makeAccountService() -> Account {
        .init(self.client)
    }

    func generateNewUserID() -> String {
        ID.unique()
    }

}
