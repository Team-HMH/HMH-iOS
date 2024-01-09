//
//  MyPageProfilButton.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class MyPageProfilButton: UIView {
    private let profilButtonStackView = UIStackView().then {
        $0.alignment = .center
        $0.axis = .vertical
    }
    
    private let profilLabel = UILabel().then {
        $0.font = .iosText6Medium14
    }
    
    private let pointStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.alignment = .center
    }
    
    private let pointLabel = UILabel().then {
        $0.font = .iosTitle4Semibold20
        $0.textColor = .gray2
        $0.text = "P"
    }
    
    private let myPointLabel = UILabel().then {
        $0.font = .iosTitle4Semibold20
        $0.textColor = .whiteText
        $0.text = "0"
    }
    
    private let mybadgeImageView = UIImageView().then {
        $0.image = .iosBadgeIcDisabled
    }
    
    init(buttonType: MyPageProfilButtonType, labelText: String, labelColor: UIColor) {
        super.init(frame: .zero)
        self.profilButtonType = buttonType
        profilLabel.text = labelText
        profilLabel.textColor = labelColor
        
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
        self.addSubview(profilButtonStackView)
        profilButtonStackView.addArrangeSubViews([])
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
        
        switch profilButtonType {
        case .pointButton:
            self.isEnabled = true
            self.backgroundColor = .gray6
            buttonContentLabel.textColor = .whiteText
            
        case .badgeButton:
            self.isEnabled = false
            self.backgroundColor = .gray7
            buttonContentLabel.textColor = .gray4
        }
    }
    
    private func updateStyle() {
        if isChecked {
            backgroundColor = .bluePurpleButton
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
            setChecked(!isChecked)
            
        case .disabled:
            return
        }
    }
}
