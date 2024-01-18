//
//  HMHDeleteAlert.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/18/24.
//

import UIKit

import SnapKit
import Then

final class HMHDeleteAlert: UIView {
    weak var delegate: AlertDelegate?
    var appName: String = ""
    
    private let titleLabel = UILabel().then {
        $0.textColor = .whiteText
        $0.font = .iosText5Medium16
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.text = "정말 인스타그램" + StringLiteral.AlertTitle.delete
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = StringLiteral.AlertDescription.delete
        $0.textColor = .whiteText
        $0.font = .iosDetail1Regular14
        $0.textAlignment = .center
        $0.setTextWithLineHeight(text: StringLiteral.AlertDescription.delete, lineHeight: 21)
        $0.numberOfLines = .zero
    }
    
    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 7
    }
    
    private let cancelButton = CustomAlertButton(buttonType: .disabled, buttonText: StringLiteral.AlertButton.confirm)
    private let confirmButton = CustomAlertButton(buttonType: .enabled, buttonText: StringLiteral.AlertButton.cancel)
    
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
        self.addSubviews(titleLabel, descriptionLabel, buttonStackView)
        buttonStackView.addArrangeSubViews([cancelButton, confirmButton])
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35.adjusted)
            $0.horizontalEdges.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20.adjustedWidth)
            $0.bottom.equalToSuperview().inset(19.adjusted)
        }
    }
    
    private func setAddTarget() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    private func configureView() {
        self.do {
            $0.makeCornerRound(radius: 10.adjusted)
            $0.backgroundColor = .gray7
        }
    }
    
    func setAppName(appName: String) {
        self.titleLabel.text = appName + StringLiteral.AlertTitle.delete
    }
    
    @objc func cancelButtonTapped() {
        delegate?.alertDismissTapped()
    }
    
    @objc func confirmButtonTapped() {
        delegate?.alertDismissTapped()
    }
}

