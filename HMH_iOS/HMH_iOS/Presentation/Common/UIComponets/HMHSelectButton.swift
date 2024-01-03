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
    
    @frozen
    enum CheckType {
        case solitary
        case multiple
    }
    
    private var selctButtonType: HMHSelectButtonType = .disabled
    private var checkType: CheckType = .solitary
    private var isChecked: Bool = false
    
    private let buttonContentLabel = UILabel().then {
        $0.font = UIFont.iosText5Medium16
    }
    
    init(buttonType: HMHSelectButtonType, checkType:CheckType, buttonText: String) {
        super.init(frame: .zero)
        self.selctButtonType = buttonType
        self.checkType = checkType
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
        switch selctButtonType {
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
    
    private func updateStyle() {
        if isChecked {
            backgroundColor = .bluePurpleActive
            makeBorder(width: 1.5, color: .bluePurpleLine)
        } else {
            backgroundColor = UIColor.gray6
            layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    private func setChecked(_ checked: Bool) {
        isChecked = checked
        updateStyle()
    }
    
    @objc private func onboardingButtonTapped() {
        switch checkType {
        case .solitary:
            guard !isChecked else { return }
            
            superview?.subviews.forEach { subview in
                if let button = subview as? HMHSelectButton, button != self {
                    button.setChecked(false)
                }
            }
            
            setChecked(true)
            
        case .multiple:
            setChecked(!isChecked)
        }
    }
}
