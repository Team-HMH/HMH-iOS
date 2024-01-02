//
//  HMHNavigationBar.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/2/24.
//

import UIKit

import SnapKit
import Then

final class HMHNavigationBar: UIView {
    @frozen
    enum NavigationBarType {
        case normal
        case logo
    }
    
    private weak var viewController: UIViewController?
    private let type: NavigationBarType
    
    private lazy var backArrowButton = UIButton().then {
        $0.setImage(ImageLiterals.NavigationBar.icArrowLeft, for: .normal)
        $0.addTarget(self, action: #selector(backArrowButtonTapped), for: .touchUpInside)
        $0.isHidden = true
    }
    
    private lazy var pointImageView = UIImageView().then {
        $0.backgroundColor = .blue
        $0.isHidden = true
    }
    
    private lazy var logoImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.iosText3Semibold18
        $0.isHidden = true
    }
    
    init(_ viewController: UIViewController, leftItem type: NavigationBarType, isBackButton: Bool, isTitleLabel: Bool, isPointImage: Bool, titleText: String? = nil) {
        self.viewController = viewController
        self.type = type
        super.init(frame: .zero)
        self.backgroundColor = .black
        
        backArrowButton.isHidden = !isBackButton
        titleLabel.isHidden = !isTitleLabel
        pointImageView.isHidden = !isPointImage
        titleLabel.text = titleText
        
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
        switch type {
        case .normal:
            self.addSubviews(backArrowButton, titleLabel, pointImageView)
            
        case .logo:
            self.addSubviews(logoImageView)
        }
    }
    
    private func setConstraints() {
        switch type {
        case .normal:
            backArrowButton.snp.makeConstraints {
                $0.top.equalToSuperview().offset(20)
                $0.leading.equalToSuperview().inset(20)
                $0.size.equalTo(24)
            }
            
            titleLabel.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
            
            pointImageView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().inset(20)
                $0.size.equalTo(24)
            }
            
        case .logo:
            logoImageView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(20)
                $0.leading.equalToSuperview().inset(20)
                $0.size.equalTo(24)
            }
        }
    }
}

extension HMHNavigationBar {
    @objc private func backArrowButtonTapped() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
