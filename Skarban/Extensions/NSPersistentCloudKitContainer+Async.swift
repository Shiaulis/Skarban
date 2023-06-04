//
//  NSPersistentCloudKitContainer+Async.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 26.02.2023.
//

import CoreData

extension NSPersistentCloudKitContainer {

    @discardableResult func loadPersistentStores() async throws -> NSPersistentStoreDescription {
        try await withCheckedThrowingContinuation { continuation in
            self.loadPersistentStores { storeDescription, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                continuation.resume(returning: storeDescription)
            }
        }
    }

}
