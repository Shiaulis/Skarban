//
//  NetworkClient.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 04.06.2023.
//

import Foundation
import Appwrite

/// Client to do tasks on a network layer
protocol NetworkClient: ApplicationClient {
    func createAccount(email: String, password: String) async throws -> AccountUser
    func createOAuthSession() async throws
}

struct AccountSession {
    init() {}
    init(session: Appwrite.Session) {}
}

struct AccountUser {
    init() {}
    init<T: Codable>(user: Appwrite.User<T>) {}
}

final class AppwriteNetworkClient: NetworkClient {

    // MARK: - Properties -
    private let authenticationService: AuthenticationService
    private let appwriteClient: Appwrite.Client

    private lazy var accountEndpoint = Appwrite.Account(self.appwriteClient)

    // MARK: - Init -

    init(authenticationService: AuthenticationService) {
        self.authenticationService = authenticationService
        self.appwriteClient = Appwrite.Client()
            .setEndpoint("https://cloud.appwrite.io/v1")
            .setProject("647bb78335f05ef274c5")
    }

    // MARK: - Network client interface

    func createAccount(email: String, password: String) async throws -> AccountUser {
        let userID = Appwrite.ID.unique()
        let user = try await self.accountEndpoint.create(userId: userID, email: email, password: password)
        return AccountUser(user: user)
    }

    func getAccountUser() async throws -> AccountUser {
        let user = try await self.accountEndpoint.get()
        return AccountUser(user: user)
    }

    func createSession() async throws -> AccountSession {
        let session = try await self.accountEndpoint.createEmailSession(email: "", password: "")
        return AccountSession(session: session)
    }

    func createOAuthSession() async throws {
        let session = try await self.accountEndpoint.createOAuth2Session(provider: "apple")
    }

}

final class InMemoryNetworkClient: NetworkClient {
    func createOAuthSession() async throws {}

    func createAccount(email: String, password: String) async throws -> AccountUser {
        .init()
    }

}
