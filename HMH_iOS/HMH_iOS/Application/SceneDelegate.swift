//
//  SceneDelegate.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 12/23/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = UINavigationController(rootViewController: TabBarController())
            if let navigationController = window?.rootViewController as? UINavigationController {
                navigationController.isNavigationBarHidden = true
            }
            window?.makeKeyAndVisible()
        }
}
