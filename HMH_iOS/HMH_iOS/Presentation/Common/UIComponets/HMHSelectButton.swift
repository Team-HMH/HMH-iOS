//
//  HMHSelectButton.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/3/24.
//

import UIKit

import SnapKit
import Then

final class HMHSelectButton: UIButton {
    @frozen
    enum HMHSelectButtonType {
        case enable
        case disabled
    }
    
    private var type: HMHSelectButtonType = .disabled
    
    private let buttonContentLabel = UILabel().then {
        $0.font = UIFont.iosText5Medium16
    }
    
    init(leftItem type: HMHSelectButtonType, buttonText: String) {
        super.init(frame: .zero)
        self.type = type
        buttonContentLabel.text = buttonText
        
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
        self.addSubview(buttonContentLabel)
    }
    
    private func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(62.adjusted)
        }
        
        buttonContentLabel.snp.makeConstraints {
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
                $0.isEnabled = true
                $0.backgroundColor = UIColor.gray6
            }
            
            buttonContentLabel.do {
                $0.textColor = UIColor.whiteText
            }
        case .disabled:
            self.do {
                $0.isEnabled = false
                $0.backgroundColor = UIColor.gray7
            }
            
            buttonContentLabel.do {
                $0.textColor = UIColor.gray4
            }
        }
    }
}
