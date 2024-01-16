//
//  ChallengePopUpController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/15/24.
//

import UIKit

final class ChallengePopUpController: UIViewController {
    
    private let createAlert = CreateChallengeAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        setUI()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraint()
    }
    
    private func setHierarchy() {
        view.addSubviews(createAlert)
    }
    
    private func setConstraint() {
        createAlert.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(177.adjusted)
            $0.width.equalTo(293.adjusted)
        }
    }
    
    private func setAlertView(logout: Bool, quit: Bool) {
        createAlert.isHidden = !logout
    }
}

