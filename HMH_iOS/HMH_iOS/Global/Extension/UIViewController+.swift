//
//  UIViewController+.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/13/24.
//

import UIKit

extension UIViewController {
    func setRootViewController(_ viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        guard let delegate = sceneDelegate else {
            return
        }
        delegate.window?.rootViewController = navigationController
    }
}

