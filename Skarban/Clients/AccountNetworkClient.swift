//
//  AccountNetworkClient.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import os.log
import Appwrite

protocol ApplicationClient {}

protocol AccountNetworkClient: ApplicationClient {

    func createAccount(email: String, password: String) async throws -> AccountUser

}

struct AccountUser {
    init() {}
    init<T: Codable>(user: User<T>) {}
}

final class AppwriteAccountNetworkClient: AccountNetworkClient {

    // MARK: - Properties -
    private let appwriteService: AppwriteService
    private lazy var accountService: Appwrite.Account = self.appwriteService.makeAccountService()
    private let logger: Logger = .init(subsystem: Bundle.main.bundleIdentifier ?? "com.shiaulis.Skarban", category: "AppwriteNetworkClient")

    // MARK: - Init -

    init(appwriteService: AppwriteService) {
        self.appwriteService = appwriteService
    }

    // MARK: - Network client interface

    func createAccount(email: String, password: String) async throws -> AccountUser {
        let userID = self.appwriteService.generateNewUserID()
        let user = try await self.accountService.create(userId: userID, email: email, password: password)
        return AccountUser(user: user)
    }
}

final class InMemoryAccountNetworkClient: AccountNetworkClient {

    func createAccount(email: String, password: String) async throws -> AccountUser {
        .init()
    }

}
