//
//  SignInSuccessViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class SignInCompleteViewController: OnboardingBaseViewController {
    private let SignInMainLabel = UILabel().then {
        $0.textColor = .whiteText
        $0.font = .iosTitle3Semibold22
        $0.text = StringLiteral.OnboardigMain.signInComplete
    }
    private let SignInSubLabel = UILabel().then {
        $0.textColor = .gray2
        $0.font = .iosText6Medium14
        $0.text = StringLiteral.OnboardigSub.signInComplete
        $0.setTextWithLineHeight(text: $0.text, lineHeight: 21)
    }
    
    private let SignInImageView = UIImageView().then {
        $0.image = ImageLiterals.myPage.icBadge
        $0.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBaseView()
        setDelegate()
        setUI()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubviews(SignInMainLabel,SignInSubLabel,SignInImageView)
    }
    
    private func setConstraints() {
        SignInImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(126.adjustedHeight)
            $0.size.equalTo(150.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        SignInMainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(SignInImageView.snp.bottom).offset(27.adjustedHeight)
        }
        
        SignInSubLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(SignInMainLabel.snp.bottom).offset(8.adjustedHeight)
        }
    }
    
    private func setDelegate() {
        self.delegate = self
    }
    
    private func configureBaseView() {
        view.backgroundColor = .background
        progressBar.isHidden = true
        nextButton.setButtonText(buttonTitle: StringLiteral.OnboardingButton.confirm)
        nextButton.updateStatus(isEnabled: true)
    }
}

extension SignInCompleteViewController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = TabBarController()
        let navigationController = UINavigationController(rootViewController: nextViewController)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        guard let delegate = sceneDelegate else {
            return
        }
        delegate.window?.rootViewController = navigationController
    }
}


