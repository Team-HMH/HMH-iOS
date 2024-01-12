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
}

final class AlertViewController: UIViewController {
    var alertType: AlertType?
    var okAction: (() -> Void)?
    
    private let logoutAlert = HMHLogoutAlert()
    private let quitAlert = HMHQuitAlert()    
    
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
        view.addSubviews(logoutAlert, quitAlert)
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
    }
    
    private func setAlertType() {
        switch alertType {
        case .HMHLogoutAlert:
            setAlertView(logout: true, quit: false)
        case .HMHQuitALert:
            setAlertView(logout: false, quit: true)
        default:
            break
        }
    }
    
    private func setAlertView(logout: Bool, quit: Bool) {
        logoutAlert.isHidden = !logout
        quitAlert.isHidden = !quit
    }
    
    func setDelegate() {
        logoutAlert.delegate = self
        quitAlert.delegate = self
    }
    
    func emptyActions() {
        
    }
    
    func setAlertType(_ type: AlertType) {
        self.alertType = type
    }
}

extension AlertViewController: AlertDelegate {
    func enabledButtonTapped() {
        dismiss(animated: false)
    }
    
    func alertDismissTapped() {
        dismiss(animated: false) {
            (self.okAction ?? self.emptyActions)()
        }
    }
}
