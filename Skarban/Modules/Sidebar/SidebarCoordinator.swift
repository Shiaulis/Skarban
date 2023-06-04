//
//  SidebarCoordinator.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 27.02.2023.
//

import Foundation
import UIKit

enum SidebarItem {
    case skarblist
    // in future I plan to move this to a separate button,
    // but for sake of testing I need a separate section in sidebar for now
    case preferences

    var image: UIImage? {
        switch self {
            case .skarblist: return .init(systemName: "list.number")
            case .preferences: return .init(systemName: "wrench.and.screwdriver")
        }
    }

    var title: String {
        switch self {
            case .skarblist: return NSLocalizedString("Items list", comment: "title of item on sidebar")
            case .preferences: return NSLocalizedString("Preferences", comment: "title of item on sidebar")
        }
    }
}

final class SidebarCoordinator: Coordinator {

    @Published private(set) var currentItem: SidebarItem = .skarblist

    var viewController: UIViewController { self.sidebarViewController }

    private let sidebarController = SidebarController()
    private let sidebarViewController = SidebarViewController()

    func start() {}

    func stop() {}
}
