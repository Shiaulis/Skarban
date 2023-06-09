//
//  AccountDatabaseClient.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 05.06.2023.
//

import Foundation

protocol AccountDatabaseClient {

    func store(accountUser: AccountUser) async throws

}

final class KeychainAccountDatabaseClient: AccountDatabaseClient {

    // MARK: - AccountDatabaseClient -

    func store(accountUser: AccountUser) async throws {}

}
