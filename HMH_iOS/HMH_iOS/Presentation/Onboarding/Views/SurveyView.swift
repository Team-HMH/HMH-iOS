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
    
    lazy var firstButton = HMHSelectButton(buttonType: .solitary)
    lazy var secondButton = HMHSelectButton(buttonType: .solitary)
    lazy var thirdButton = HMHSelectButton(buttonType: .solitary)
    lazy var fourthButton = HMHSelectButton(buttonType: .solitary)
    
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
            $0.height.equalTo(275.adjusted)
        }
    }
    
    private func setAddTarget() {
    }
    
    private func configureView() {
    }
}
