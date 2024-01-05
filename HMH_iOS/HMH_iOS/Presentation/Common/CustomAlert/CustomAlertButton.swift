//
//  CustomAlertButton.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class CustomAlertButton: UIButton {
    @frozen
    enum HMHAlertButtonType {
        case disabled
        case enabled
    }
    private var alertButtonType: HMHAlertButtonType = .disabled
    private let buttonTitleLabel = UILabel().then {
        $0.textColor = .whiteText
        $0.font = .iosText6Medium14
    }
    
    init(buttonType: HMHAlertButtonType, buttonText: String) {
        super.init(frame: .zero)
        self.alertButtonType = buttonType
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
        self.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        buttonTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func configureButton() {
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        
        switch alertButtonType {
        case .enabled:
            self.isEnabled = true
            self.backgroundColor = .bluePurpleButton
            
        case .disabled:
            self.isEnabled = false
            self.backgroundColor = .gray4
        }
    }
}
