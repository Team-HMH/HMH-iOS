//
//  OnboardingButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/3/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingButton: UIButton {
    @frozen
    enum OnboardingButtonType {
        case enable
        case disabled
    }
    
    private var type: OnboardingButtonType = .enable
    
    private let buttonTitleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.iosText3Semibold18
        $0.isHidden = true
    }
    
    init(leftItem type: OnboardingButtonType, buttonText: String) {
        super.init(frame: .zero)
        self.type = type
        buttonTitleLabel.text = buttonText
        
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
        buttonTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configureButton() {
        self.do {
            $0.makeCornerRound(radius: 6.adjustedHeight)
            $0.layer.cornerCurve = .continuous
        }
        switch type {
        case .enable:
            self.do {
                $0.backgroundColor = .purple
            }
        case .disabled:
            self.do {
                $0.backgroundColor = .gray
            }
        }
    }

}