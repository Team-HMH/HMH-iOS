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
    
    private let swipeView = OnboardingSwipeView()
    let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppleLoginButton()
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
}

extension LoginViewController {
    
    func setAppleLoginButton() {
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.view.addSubview(authorizationButton)
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //로그인 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                if let unwrappedFullName = fullName, let givenName = unwrappedFullName.givenName, let familyName = unwrappedFullName.familyName {
                    UserManager.shared.updateUserName(givenName, familyName)
                } else {
                    print("fullName이 없거나 givenName 또는 familyName이 없습니다.")
                }
                UserManager.shared.updateUserIdentifier(userIdentifier)
            }
            
            // 로그인이 성공 한다면
            // 소셜 로그인 API 쏘기 403 -> 온보딩 뷰로 이동
            // 회원 가입이 필요한지 아닌지 확인, userId가 있는지 없는지 판별
            // 유저 메니저와 signInModel에 해당 값 저장
            
            print(UserManager.shared.getUserIdentifier)
            print(UserManager.shared.getUserName)
            if (UserManager.shared.appleUserIdentifier != nil) {
                let nextViewController = TabBarController()
                self.navigationController?.pushViewController(nextViewController, animated: true)
            } else {
                let nextViewController = TimeSurveyViewController()
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
    
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 로그인 실패(유저의 취소도 포함)
        print("login failed - \(error.localizedDescription)")
    }
}


