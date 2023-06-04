//
//  AppwriteService.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import Appwrite

final class AppwriteService: AppService {

    // MARK: - Properties -

    private var client: Client!

    // MARK: - AppService API

    func load() async throws {
        self.client = Client()
            .setEndpoint("https://cloud.appwrite.io/v1")
            .setProject("647bb78335f05ef274c5")
    }


    func start() async throws {}

    func stop() async {}

}
