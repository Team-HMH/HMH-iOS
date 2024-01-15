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
        setLoginView()
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
            $0.height.equalTo(480.adjusted)
        }
    }
    
    private func setLoginView() {
        view.backgroundColor = .background
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
            
            if  let identityToken = appleIDCredential.identityToken,
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                if let unwrappedFullName = fullName, let givenName = unwrappedFullName.givenName, let familyName = unwrappedFullName.familyName {
                    UserManager.shared.updateUserName(givenName, familyName)
                } else {
                    print("fullName이 없거나 givenName 또는 familyName이 없습니다.")
                }
                UserManager.shared.updateAppleToken(identifyTokenString)
                UserManager.shared.updateUserIdentifier(userIdentifier)
            }
            let request = SocialLoginRequestDTO(socialPlatform: "APPLE")
            
            let provider = Providers.AuthProvider
            
            provider.request(target: .socialLogin(data: request), instance: BaseResponse<SocialLogineResponseDTO>.self, viewController: LoginViewController()) { data in
                if data.status == 403 {
                    let nextViewController = TimeSurveyViewController()
                    self.navigationController?.pushViewController(nextViewController, animated: false)
                } else if data.status == 200 {
                    self.setRootViewController(TabBarController())
                    guard let data = data.data else { return }
                    UserManager.shared.updateToken(data.token.accessToken, data.token.refreshToken)
                    UserManager.shared.updateUserId(data.userId)
                }
            }
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("login failed - \(error.localizedDescription)")
    }
}


