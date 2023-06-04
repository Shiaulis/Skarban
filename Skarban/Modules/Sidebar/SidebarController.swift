//
//  SidebarController.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 27.02.2023.
//

import Foundation

final class SidebarController {

    private static let initialItemsList: [SidebarItem] = [
        .skarblist,
        .preferences
    ]

    @Published private(set) var itemsList: [SidebarItem] = initialItemsList

}
