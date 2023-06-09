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

    var rootViewController: UIViewController! { get set }

    func start()
    func stop()
    
}
