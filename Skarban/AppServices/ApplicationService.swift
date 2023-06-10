//
//  AppService.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 27.02.2023.
//

import Foundation

protocol ApplicationService {
    func load() async throws
    func start() async throws
    func stop() async
}
