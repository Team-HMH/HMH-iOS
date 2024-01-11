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
    func setAppleLoginButton() {
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.view.addSubview(authorizationButton)
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        print(request, "👍")
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc func appleButtonTaped() {
        print("tap")
    }
    
    let swipeView = OnboardingSwipeView()
    
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


extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //로그인 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // You can create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            UserDefaults.standard.set(userIdentifier, forKey: "userIdentifier")
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authCodeString: \(authCodeString)")
                print("identifyTokenString: \(identifyTokenString)")
                print("🚨", appleIDCredential)
                if let bundleID = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: bundleID)
                }
                //                saveToUserDefaults("authorizationCode",keyValue: authorizationCode)
                //                saveToUserDefaults("identityToken",keyValue: identityToken)
                //                saveToUserDefaults(authCodeString,keyValue:"authCodeString")
                //                saveToUserDefaults(identifyTokenString,keyValue:"identifyTokenString")
                //                saveToUserDefaults("cool",keyValue:"userIdentifier")
                
            }
            
            print("useridentifier: \(userIdentifier)")
            
            
            
            //Move to MainPage
            //let validVC = SignValidViewController()
            //validVC.modalPresentationStyle = .fullScreen
            //present(validVC, animated: true, completion: nil)
            
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    
    func saveToUserDefaults(_ content: String, keyValue: String) {
        // Save the userId to UserDefaults
        UserDefaults.standard.set(content, forKey: keyValue)
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 로그인 실패(유저의 취소도 포함)
        print("login failed - \(error.localizedDescription)")
    }
}
