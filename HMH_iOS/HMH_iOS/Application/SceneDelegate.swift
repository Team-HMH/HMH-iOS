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
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let splashViewController = SplashViewController()
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async{
                showLoginViewController()
            }
        }
        
        func showTabBarViewController() {
            let tabBarViewController = TabBarController()
            navigateTo(viewController: tabBarViewController)
        }
        
        func showLoginViewController() {
            let loginViewController = LoginViewController()
            navigateTo(viewController: loginViewController)
        }
        
        func navigateTo(viewController: UIViewController) {
            DispatchQueue.main.async {
                if let navigationController = self.window?.rootViewController as? UINavigationController {
                    navigationController.pushViewController(viewController, animated: true)
                } else {
                    let navigationController = UINavigationController(rootViewController: viewController)
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                }
            }
        }
    }
}
