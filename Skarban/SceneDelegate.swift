//
//  SceneDelegate.swift
//  Skarban
//
//  Created by Andrius Shiaulis on 26.02.2023.
//

import UIKit
import Appwrite

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties -

    var window: UIWindow?

    // MARK: - UIWindowSceneDelegate -

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        ApplicationCore.shared.start(scene, in: window)
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url,
            url.absoluteString.contains("appwrite-callback") else {
            return
        }
        WebAuthComponent.handleIncomingCookie(from: url)
    }


}

