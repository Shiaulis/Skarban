//
//  AppDelegate.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 26.02.2023.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    private var applicationCore: ApplicationCore!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}

