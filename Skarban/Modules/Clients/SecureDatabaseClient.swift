//
//  SecureDatabaseClient.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 05.06.2023.
//

import Foundation

/// Client to do tasks tasks on database layer for sensitive tasks.
protocol SecureDatabaseClient: ApplicationClient {

    func store<T: Codable>(_ object: T?, forKey: SecureDatabaseClientKey) async throws
    func getObject<T: Codable>(forKey: SecureDatabaseClientKey) async throws -> T?

}

enum SecureDatabaseClientKey: String {
    case accountSession
}

final class KeychainSecureDatabaseClient: SecureDatabaseClient {

    let userDefaults: UserDefaults = .standard

    func store<T: Codable>(_ object: T?, forKey key: SecureDatabaseClientKey) async throws {
        guard let object else {
            self.userDefaults.removeObject(forKey: key.rawValue)
            return
        }

        let codeObject = try JSONEncoder().encode(object)
        self.userDefaults.set(codeObject, forKey: key.rawValue)
    }

    func getObject<T: Codable>(forKey key: SecureDatabaseClientKey) async throws -> T? {
        guard let codeObject = self.userDefaults.object(forKey: key.rawValue) as? Data else {
            return nil
        }

        let object = try JSONDecoder().decode(T.self, from: codeObject)
        return object
    }

}

final class InMemorySecureDatabaseClient: SecureDatabaseClient {

    func store<T: Codable>(_ object: T?, forKey: SecureDatabaseClientKey) async throws {

    }
    
    func getObject<T: Codable>(forKey: SecureDatabaseClientKey) async throws -> T? {
        nil
    }


}
