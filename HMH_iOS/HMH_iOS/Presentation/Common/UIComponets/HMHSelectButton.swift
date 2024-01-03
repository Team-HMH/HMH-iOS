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
        addTarget()
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
    
    private func addTarget() {
        self.addTarget(self, action: #selector(onboardingButtonTapped), for: .touchUpInside)
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
    
    private func setSelected() {
        self.backgroundColor = .bluePurpleActive
        self.makeBorder(width: 1.5, color: .bluePurpleLine)
    }
    
    @objc private func onboardingButtonTapped() {
        guard !isSelected else { return }
        
        superview?.subviews.forEach { subview in
            if let button = subview as? HMHSelectButton, button != self {
                button.isSelected = false
                button.backgroundColor = UIColor.gray6
                button.layer.borderColor = UIColor.clear.cgColor
            }
        }

        isSelected = true
        setSelected()
    }
}
