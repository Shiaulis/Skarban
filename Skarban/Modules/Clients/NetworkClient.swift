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
    var authenticationMonitorDelegate: AuthenticationMonitorDelegate? { get set }

    func createAccount(email: String, password: String) async throws -> AccountUser
    func startAccountSession(email: String, password: String) async throws -> AccountSession
    func createOAuthSession() async throws
}

struct AccountSession: Codable, Equatable {
    let creationDate: Date?
    let expirationDate: Date?
    let id: String
    let userID: String
    let isCurrent: Bool

    static let dummy: AccountSession = .init(
        creationDate: .now,
        expirationDate: .now.addingTimeInterval(60 * 60),
        id: UUID().uuidString,
        userID: UUID().uuidString,
        isCurrent: true
    )
}

struct AccountUser {
    init() {}
    init<T: Codable>(user: Appwrite.User<T>) {}
}

final class AppwriteNetworkClient: NetworkClient {

    // MARK: - Properties -
    lazy var authenticationMonitorDelegate: AuthenticationMonitorDelegate? = nil
    private let appwriteClient: Appwrite.Client

    private lazy var accountEndpoint = Appwrite.Account(self.appwriteClient)

    // MARK: - Init -

    init() {
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

    func startAccountSession(email: String, password: String) async throws -> AccountSession {
        self.authenticationMonitorDelegate?.authenticationStarted()
        let session = try await self.accountEndpoint.createEmailSession(email: email, password: password)
        let accountSession = makeAccountSession(from: session)
        self.authenticationMonitorDelegate?.accountSessionUpdated(accountSession)
        return accountSession
    }

    func createOAuthSession() async throws {
        let session = try await self.accountEndpoint.createOAuth2Session(provider: "apple")
    }

    func makeAccountSession(from appwriteSession: Appwrite.Session) -> AccountSession {
        let formatter: ISO8601DateFormatter = .init()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let creationDate = formatter.date(from: appwriteSession.createdAt)
        // FIXME: Current format
        let expirationDate = formatter.date(from: appwriteSession.expire)

        return .init(
            creationDate: creationDate,
            expirationDate: expirationDate,
            id: appwriteSession.id,
            userID: appwriteSession.userId,
            isCurrent: appwriteSession.current
        )
    }

}

final class InMemoryNetworkClient: NetworkClient {

    lazy var authenticationMonitorDelegate: AuthenticationMonitorDelegate? = nil

    func startAccountSession(email: String, password: String) async throws -> AccountSession { .dummy }

    func createOAuthSession() async throws {}

    func createAccount(email: String, password: String) async throws -> AccountUser {
        .init()
    }

}
