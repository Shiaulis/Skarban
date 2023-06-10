//
//  Logger+Init.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 10.06.2023.
//

import Foundation
import OSLog

extension Logger {

    private static var bundleIdentifier: String { Bundle.main.bundleIdentifier ?? "com.shiaulis.Skarban" }

    /// Convenient init that is using main bundle identifier as subsystem and reporter type as category
    init<Reporter>(reporterType: Reporter.Type) {
        self.init(subsystem: Self.bundleIdentifier, category: String(describing: reporterType.self))
    }

    init(category: String) {
        self.init(subsystem: Self.bundleIdentifier, category: category)
    }

}
