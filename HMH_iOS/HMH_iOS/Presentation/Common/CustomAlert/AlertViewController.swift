//
//  AlertViewController.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/6/24.
//

import UIKit
import ManagedSettings

enum AlertType {
    case HMHLogoutAlert
    case HMHQuitAlert
    case HMHPushAlert
    case HMHChallengeAlert
}

final class AlertViewController: UIViewController {
    var alertType: AlertType?
    var okAction: (() -> Void)?
    let store = ManagedSettingsStore(named: .default)
    
    private let logoutAlert = HMHLogoutAlert()
    private let quitAlert = HMHQuitAlert()
    private let pushAlert = HMHPushAlert()
    private let challengeAlert = ChallengeAlert()
    
    var appName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        pushAlert.setAppName(appName: appName)
        setDelegate()
        setAlertType()
        setUI()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraint()
    }
    
    private func setHierarchy() {
        view.addSubviews(logoutAlert, quitAlert, pushAlert, challengeAlert)
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
        
        pushAlert.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(222.adjusted)
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
            setAlertView(logout: true, quit: false, push: false, challenge: false)
        case .HMHQuitAlert:
            setAlertView(logout: false, quit: true, push: false, challenge: false)
        case .HMHPushAlert:
            setAlertView(logout: false, quit: false, push: true, challenge: false)
        case .HMHChallengeAlert:
            setAlertView(logout: false, quit: false, push: false, challenge: true)
        default:
            break
        }
    }
    
    private func setAlertView(logout: Bool, quit: Bool, push: Bool, challenge: Bool) {
        logoutAlert.isHidden = !logout
        quitAlert.isHidden = !quit
        pushAlert.isHidden = !push
        challengeAlert.isHidden = !challenge
    }
    
    func setDelegate() {
        logoutAlert.delegate = self
        quitAlert.delegate = self
        pushAlert.delegate = self
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
        let provider = Providers.AuthProvider
        if alertType == .HMHQuitAlert {
            provider.request(target: .revoke, instance: BaseResponse<RevokeResponseDTO>.self, viewController: self) { data in
                UserManager.shared.clearData()
            }
            
            dismiss(animated: false) {
                self.setRootViewController(LoginViewController())
            }
        } else if alertType == .HMHLogoutAlert {
            let provider = Providers.AuthProvider
            
            provider.request(target: .logout, instance: BaseResponse<LogoutResponseDTO>.self, viewController: self) { data in
                UserManager.shared.clearAll()
            }
            
            dismiss(animated: false) {
                self.setRootViewController(LoginViewController())
            }
        }
        
    }
    
    
    func alertDismissTapped() {
        if alertType == .HMHPushAlert {
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none
        }
        dismiss(animated: false) {
            (self.okAction ?? self.emptyActions)()
        }
    }
}
