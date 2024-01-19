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
    case HMHPushALert
    case Challenge
    case delete
}

final class AlertViewController: UIViewController {
    var alertType: AlertType?
    var okAction: (() -> Void)?
    
    private let logoutAlert = HMHLogoutAlert()
    private let quitAlert = HMHQuitAlert()
    private let pushAlert = HMHPushAlert()
    private let challengeAlert = ChallengeAlert()
    private let deleteAlert = HMHDeleteAlert()
    
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
        view.addSubviews(logoutAlert, quitAlert, pushAlert, challengeAlert, deleteAlert)
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
        
        deleteAlert.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(222.adjusted)
            $0.width.equalTo(293.adjusted)
        }
    }
    
    private func setAlertType() {
        switch alertType {
        case .HMHLogoutAlert:
            setAlertView(logout: true, quit: false, push: false, challenge: false, delete: false)
        case .HMHQuitALert:
            setAlertView(logout: false, quit: true, push: false, challenge: false, delete: false)
        case .HMHPushALert:
            setAlertView(logout: false, quit: false, push: true, challenge: false, delete: false)
        case .Challenge:
            setAlertView(logout: false, quit: false, push: false, challenge: true, delete: false)
        case .delete:
            setAlertView(logout: false, quit: false, push: false, challenge: false, delete: true)
        default:
            break
        }
    }
    
    private func setAlertView(logout: Bool, quit: Bool, push: Bool, challenge: Bool, delete: Bool) {
        logoutAlert.isHidden = !logout
        quitAlert.isHidden = !quit
        pushAlert.isHidden = !push
        challengeAlert.isHidden = !challenge
        deleteAlert.isHidden = !delete
    }
    
    func setDelegate() {
        logoutAlert.delegate = self
        quitAlert.delegate = self
        pushAlert.delegate = self
        challengeAlert.delegate = self
        deleteAlert.delegate = self
    }
    
    func emptyActions() {
        
    }
    
    func setAlertType(_ type: AlertType) {
        self.alertType = type
    }
}

extension AlertViewController: AlertDelegate {
    func deleteButtonTapped() {
        let challengeController = ChallengeViewController()
        challengeController.deleteTap()
        dismiss(animated: false) {
            (self.okAction ?? self.emptyActions)()
        }
    }
    func confirmButtonTapped() {
        setRootViewController(TabBarController())
    }
    
    func enabledButtonTapped() {
        let provider = Providers.AuthProvider
        if alertType == .HMHQuitALert {
            provider.request(target: .revoke, instance: BaseResponse<RevokeResponseDTO>.self, viewController: self) { data in
                print("revoke!!!!!!")
                UserManager.shared.clearData()
            }
        } else {
            let provider = Providers.AuthProvider
            
            provider.request(target: .logout, instance: BaseResponse<LogoutResponseDTO>.self, viewController: self) { data in
                print("logout!!!!!!")
                UserManager.shared.clearAll()
            }
        }
        
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

