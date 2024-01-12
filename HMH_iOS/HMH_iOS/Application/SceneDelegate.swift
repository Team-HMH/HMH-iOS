//
//  SceneDelegate.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 12/23/23.
//

import UIKit
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    //
    func sceneDidBecomeActive(_ scene: UIScene) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "000340.8d411a5d11d84e8da0c22ef43dce465a.1657" ?? "") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("authorized")
            case .revoked:
                print("revoked")
            case .notFound:
                print("notFound")
            default:
                break
            }
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let splashViewController = SplashViewController()
        window.rootViewController = splashViewController
        window.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async{
                if UserManager.shared.hasAccessToken {
                    //애플 로그인 토큰 리프레쉬 로직. 성공한다면 엑세스와 리프레시 토큰 업데이트 그러면서 이동
                    // 토큰 리프레시가 실패 한다. 로그인 컨트롤러로 바로 이동.
//                    UserManager.shared.updateToken(,)
                    
                    showTabBarViewController()
                } else {
                    showLoginViewController()
                }
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
