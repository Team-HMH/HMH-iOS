//
//  ChallengeAlert.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/16/24.
//

import UIKit

import SnapKit
import Then

final class ChallengeAlert: UIView {
    weak var delegate: AlertDelegate?

    private let titleLabel = UILabel().then {
        $0.text = StringLiteral.AlertTitle.challenge
        $0.textColor = .whiteText
        $0.font = .iosText5Medium16
        $0.textAlignment = .center
    }

    private let challengeImageView = UIImageView().then {
        $0.image = ImageLiterals.Alert.icChallengeAlert
    }

    private let descriptionLabel = UILabel().then {
        $0.textColor = .whiteText
        $0.font = .iosDetail1Regular14
        $0.setTextWithLineHeight(text: StringLiteral.AlertDescription.challenge, lineHeight: 21)
    }

    private let confirmButton = CustomAlertButton(buttonType: .enabled, buttonText: StringLiteral.AlertButton.confirm)

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
        self.addSubviews(challengeImageView, titleLabel, descriptionLabel, confirmButton)
    }

    private func setConstraints() {
        challengeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(37.adjusted)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(120.adjusted)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(challengeImageView.snp.bottom).offset(21.adjusted)
            $0.centerX.equalTo(challengeImageView.snp.centerX)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9.adjusted)
            $0.centerX.equalTo(challengeImageView.snp.centerX)
        }

        confirmButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(18.adjusted)
            $0.width.equalTo(253.adjusted)
            $0.height.equalTo(45.adjusted)
            $0.centerX.equalTo(challengeImageView.snp.centerX)
        }
    }

    private func setAddTarget() {
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }

    private func configureView() {
        self.do {
            $0.makeCornerRound(radius: 10.adjusted)
            $0.backgroundColor = .gray7
        }
    }

    @objc func confirmButtonTapped() {
        delegate?.confirmButtonTapped()
    }
}
