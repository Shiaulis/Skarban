//
//  SecureDatabaseClient.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 05.06.2023.
//

import Foundation

/// Client to do tasks tasks on database layer for sensitive tasks.
protocol SecureDatabaseClient: ApplicationClient {

    func store(accountUser: AccountUser) async throws
    /// get current account from 
    func getAccountUser() async throws -> AccountUser?

}

final class KeychainSecureDatabaseClient: SecureDatabaseClient {

    func store(accountUser: AccountUser) async throws {}
    func getAccountUser() async throws -> AccountUser? {
        nil
    }

}

final class InMemorySecureDatabaseClient: SecureDatabaseClient {

    func store(accountUser: AccountUser) async throws {}
    func getAccountUser() async throws -> AccountUser? {
        nil
    }

}
