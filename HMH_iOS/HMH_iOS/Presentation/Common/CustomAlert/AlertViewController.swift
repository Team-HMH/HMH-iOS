//
//  AlertViewController.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/6/24.
//

import UIKit

enum AlertType {
    case HMHLogoutAlert
    case HMHQuitALert
    case Challenge
}

final class AlertViewController: UIViewController {
    var alertType: AlertType?
    var okAction: (() -> Void)?
    
    private let logoutAlert = HMHLogoutAlert()
    private let quitAlert = HMHQuitAlert()
    private let challengeAlert = ChallengeAlert()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        
        setDelegate()
        setAlertType()
        setUI()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraint()
    }
    
    private func setHierarchy() {
        view.addSubviews(logoutAlert, quitAlert, challengeAlert)
    }
    
    private func setConstraint() {
        logoutAlert.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(177.adjusted)
            $0.width.equalTo(293.adjusted)
        }
        
        quitAlert.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(203.adjusted)
            $0.width.equalTo(293.adjusted)
        }
        
        challengeAlert.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(344.adjusted)
            $0.width.equalTo(293.adjusted)
        }
    }
    
    private func setAlertType() {
        switch alertType {
        case .HMHLogoutAlert:
            setAlertView(logout: true, quit: false, challenge: false)
        case .HMHQuitALert:
            setAlertView(logout: false, quit: true, challenge: false)
        case .Challenge:
            setAlertView(logout: false, quit: true, challenge: true)
        default:
            break
        }
    }
    
    private func setAlertView(logout: Bool, quit: Bool, challenge:Bool) {
        logoutAlert.isHidden = !logout
        quitAlert.isHidden = !quit
        challengeAlert.isHidden = !challenge
    }
    
    func setDelegate() {
        logoutAlert.delegate = self
        quitAlert.delegate = self
        challengeAlert.delegate = self
    }
    
    func emptyActions() {
        
    }
    
    func setAlertType(_ type: AlertType) {
        self.alertType = type
    }
}

extension AlertViewController: AlertDelegate {
    func confirmButtonTapped() {
        setRootViewController(TabBarController())
    }
    
    func enabledButtonTapped() {
        dismiss(animated: false) {
            let loginViewController = LoginViewController()
            
            if let window = UIApplication.shared.windows.first {
                let navigationController = UINavigationController(rootViewController: loginViewController)
                navigationController.isNavigationBarHidden = true
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        }
    }

    func alertDismissTapped() {
        dismiss(animated: false) {
            (self.okAction ?? self.emptyActions)()
        }
    }
}
