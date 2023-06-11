//
//  AuthenticationMonitorDelegate.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 10.06.2023.
//

import Foundation

/// Object that passes authentication related information
protocol AuthenticationMonitorDelegate {

    func accountSessionUpdated(_ accountSession: AccountSession)
    func authenticationStarted()

}
