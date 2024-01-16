//
//  CreateChallengeAlert.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/15/24.
//

import UIKit

import SnapKit
import Then

final class CreateChallengeAlert: UIView {
    weak var delegate: AlertDelegate?
    
    private let titleLabel = UILabel().then {
        $0.text = StringLiteral.AlertTitle.quit
        $0.textColor = .whiteText
        $0.font = .iosText5Medium16
        $0.textAlignment = .center
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = StringLiteral.AlertDescription.quit
        $0.textColor = .whiteText
        $0.font = .iosDetail1Regular14
        $0.textAlignment = .center
        $0.setTextWithLineHeight(text: StringLiteral.AlertDescription.quit, lineHeight: 21)
        $0.numberOfLines = .zero
    }
    
    private let confirmButton = OnboardingButton(buttonStatus: .enabled)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddTarget()
        configureView()
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubviews(titleLabel, descriptionLabel, confirmButton)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35.adjusted)
            $0.horizontalEdges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.adjusted)
            $0.horizontalEdges.equalToSuperview().inset(44.adjusted)
        }
        
        confirmButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20.adjustedWidth)
            $0.bottom.equalToSuperview().inset(19.adjusted)
        }
    }
    
    private func setAddTarget() {
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    private func configureView() {
        self.do {
            $0.makeCornerRound(radius: 10.adjusted)
            $0.backgroundColor = .gray7
        }
    }

    @objc func confirmButtonTapped() {
//        dismiss(animated: false) {
//            let loginViewController = LoginViewController()
//            
//            if let window = UIApplication.shared.windows.first {
//                let navigationController = UINavigationController(rootViewController: loginViewController)
//                navigationController.isNavigationBarHidden = true
//                window.rootViewController = navigationController
//                window.makeKeyAndVisible()
//            }
//        }
    }
}

