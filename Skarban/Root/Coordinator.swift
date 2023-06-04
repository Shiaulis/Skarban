//
//  Coordinator.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 27.02.2023.
//

import Foundation
import UIKit

@MainActor
protocol Coordinator: AnyObject {

    init(globalContext: GlobalContext)

    var viewController: UIViewController { get }
    var rootViewController: UIViewController? { get set }

    func start()
    func stop()
    
}

extension Coordinator {

    var rootViewController: UIViewController? {
        get { nil }
        set {}
    }

}
