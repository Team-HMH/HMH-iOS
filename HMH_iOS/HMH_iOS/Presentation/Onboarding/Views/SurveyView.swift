//
//  SurveyView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class SurveyView: UIView {
    private let buttonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 9.adjusted
    }
    var firstButtonText: String = ""
    var secondButtonText: String = ""
    var thirdButtonText: String = ""
    var fourthButtonText: String = ""
    var firstButtonType: HMHSelectButton.HMHSelectButtonType = .solitary
    var secondButtonType: HMHSelectButton.HMHSelectButtonType = .solitary
    var thirdButtonType: HMHSelectButton.HMHSelectButtonType = .solitary
    var fourthButtonType: HMHSelectButton.HMHSelectButtonType = .solitary
    
    lazy var firstButton = HMHSelectButton(buttonType: firstButtonType)
    lazy var secondButton = HMHSelectButton(buttonType: secondButtonType)
    lazy var thirdButton = HMHSelectButton(buttonType: thirdButtonType)
    lazy var fourthButton = HMHSelectButton(buttonType: fourthButtonType)
    
    init(firstButtonType: HMHSelectButton.HMHSelectButtonType,
         secondButtonType: HMHSelectButton.HMHSelectButtonType,
         thirdButtonType: HMHSelectButton.HMHSelectButtonType,
         fourthButtonType: HMHSelectButton.HMHSelectButtonType) {
        super.init(frame: .zero)
        self.firstButtonType = firstButtonType
        self.secondButtonType = secondButtonType
        self.thirdButtonType = thirdButtonType
        self.fourthButtonType = fourthButtonType
        
        setAddTarget()
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
        firstButton.buttonContentLabel.text = firstButtonText
        secondButton.buttonContentLabel.text = secondButtonText
        thirdButton.buttonContentLabel.text = thirdButtonText
        fourthButton.buttonContentLabel.text = fourthButtonText

    }
    
    private func setHierarchy() {
        self.addSubview(buttonStackView)
        buttonStackView.addArrangeSubViews([firstButton, secondButton, thirdButton, fourthButton])
    }
    
    private func setConstraints() {
        buttonStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setAddTarget() {
    }
}
