//
//  OnboardingButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/8/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingButton: UIButton {
    @frozen
    enum OnboardingButtonType {
        case enabled
        case disabled
    }

    var type: OnboardingButtonType = .disabled

    private let buttonTitleLabel = UILabel().then {
        $0.textColor = .whiteText
        $0.font = .iosText4Semibold16
    }

    init(buttonStatus type: OnboardingButtonType) {
        super.init(frame: .zero)
        self.type = type

        configureButton()
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
        self.addSubview(buttonTitleLabel)
    }

    private func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(52.adjusted)
        }

        buttonTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func configureButton() {
        self.makeCornerRound(radius: 6.adjusted)
        self.layer.cornerCurve = .continuous

        switch type {
        case .enabled:
            self.isEnabled = true
            self.backgroundColor = .bluePurpleButton

        case .disabled:
            self.isEnabled = false
            self.backgroundColor = .gray5
        }
    }
    
    func setButtonText(buttonTitle: String) {
        buttonTitleLabel.text = buttonTitle
    }
    
    func updateStatus(isEnabled: Bool) {
        if isEnabled {
            self.isEnabled = true
            self.backgroundColor = .bluePurpleButton
        } else {
            self.isEnabled = false
            self.backgroundColor = .gray5
        }
    }
}

