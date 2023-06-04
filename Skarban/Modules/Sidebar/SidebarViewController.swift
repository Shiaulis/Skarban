//
//  SidebarViewController.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 26.02.2023.
//

import UIKit

final class SidebarViewController: UIViewController {

    // MARK: - Init -

    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemRed
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
