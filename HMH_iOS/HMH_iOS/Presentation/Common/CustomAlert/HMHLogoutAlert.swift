//
//  HMHLogoutAlert.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class HMHLogoutAlert: UIView {
    weak var delegate: AlertDelegate?
    
    private let titleLabel = UILabel().then {
        $0.text = StringLiteral.AlertTitle.logout
        $0.textColor = .whiteText
        $0.font = .iosText5Medium16
        $0.textAlignment = .center
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 7
    }
    
    private let leftButton = CustomAlertButton(buttonType: .disabled, buttonText: StringLiteral.AlertButton.close)
    private let rightButton = CustomAlertButton(buttonType: .enabled, buttonText: StringLiteral.AlertButton.confirm)
    
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
    }
    
    private func setHierarchy() {
        self.addSubviews(titleLabel, buttonStackView)
        buttonStackView.addArrangeSubViews([leftButton, rightButton])
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50.adjusted)
            $0.horizontalEdges.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(19.adjusted)
        }
    }
    
    private func setAddTarget() {
        leftButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    private func configureView() {
        self.do {
            $0.makeCornerRound(radius: 10.adjusted)
            $0.backgroundColor = .gray7
        }
    }
    
    @objc func exitButtonTapped() {
        delegate?.alertDismissTapped()
    }
    
    @objc func logoutButtonTapped() {
        delegate?.enabledButtonTapped()
    }
}
