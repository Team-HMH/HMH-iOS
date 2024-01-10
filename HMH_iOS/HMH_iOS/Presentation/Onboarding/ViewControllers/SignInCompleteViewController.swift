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
    
    private let signInMainLabel = UILabel().then {
        $0.textColor = .whiteText
        $0.font = .iosTitle3Semibold22
        $0.text = StringLiteral.OnboardigMain.signInComplete
    }
    private let signInSubLabel = UILabel().then {
        $0.textColor = .gray2
        $0.font = .iosText6Medium14
        $0.text = StringLiteral.OnboardigSub.signInComplete
        $0.setTextWithLineHeight(text: $0.text, lineHeight: 21)
    }
    
    private let signInImageView = UIImageView().then {
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
        view.addSubviews(signInMainLabel,signInSubLabel,signInImageView)
    }
    
    private func setConstraints() {
        signInImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(126.adjustedHeight)
            $0.size.equalTo(150.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        signInMainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(signInImageView.snp.bottom).offset(27.adjustedHeight)
        }
        
        signInSubLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(signInMainLabel.snp.bottom).offset(8.adjustedHeight)
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


