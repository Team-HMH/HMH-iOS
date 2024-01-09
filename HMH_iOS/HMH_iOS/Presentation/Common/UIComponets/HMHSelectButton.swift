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
        case solitary
        case multiple
        case disabled
    }
    
    private var selectButtonType: HMHSelectButtonType = .disabled
    private var isChecked: Bool = false
    
    var buttonContentLabel = UILabel().then {
        $0.font = UIFont.iosText5Medium16
    }
    
    init(buttonType: HMHSelectButtonType) {
        super.init(frame: .zero)
        self.selectButtonType = buttonType
        
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
        self.makeCornerRound(radius: 6.adjustedHeight)
        self.layer.cornerCurve = .continuous
        
        switch selectButtonType {
        case .solitary,.multiple:
            self.isEnabled = true
            self.backgroundColor = .gray6
            buttonContentLabel.textColor = .whiteText
            
        case .disabled:
            self.isEnabled = false
            self.backgroundColor = .gray7
            buttonContentLabel.textColor = .gray4
        }
    }
    
    private func updateStyle() {
        if isChecked {
            backgroundColor = .bluePurpleOpacity22
            makeBorder(width: 1.5, color: .bluePurpleLine)
        } else {
            backgroundColor = .gray6
            layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    private func setChecked(_ checked: Bool) {
        isChecked = checked
        updateStyle()
    }
    
    @objc private func onboardingButtonTapped() {
        switch selectButtonType {
        case .solitary:
            guard !isChecked else { return }
            
            superview?.subviews.forEach { subview in
                if let button = subview as? HMHSelectButton, button != self {
                    button.setChecked(false)
                }
            }
            
            setChecked(true)
            
        case .multiple:
            let selectedCount = (superview?.subviews.compactMap { ($0 as? HMHSelectButton)?.isChecked } ?? []).filter { $0 }.count
            
            if selectedCount < 2 || isChecked {
                setChecked(!isChecked)
            }
            
        case .disabled:
            return
        }
    }
    
    func setButtonText(buttonTitle: String) {
        buttonContentLabel.text = buttonTitle
    }
}
