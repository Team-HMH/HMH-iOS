//
//  LoginViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/9/24.
//

import UIKit

import SnapKit
import Then
import AuthenticationServices

final class LoginViewController: UIViewController {
    let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .white)
    let swipeView = OnboardingSwipeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubviews(authorizationButton, swipeView)
    }
    
    private func setConstraints() {
        authorizationButton.snp.makeConstraints {
            $0.width.equalTo(336)
            $0.height.equalTo(54)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-21.adjusted)
        }
        
        swipeView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(108.adjusted)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(480)
        }
    }
    
    private func setAppleLoginButton() {
        self.view.addSubview(authorizationButton)
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
    }
}


