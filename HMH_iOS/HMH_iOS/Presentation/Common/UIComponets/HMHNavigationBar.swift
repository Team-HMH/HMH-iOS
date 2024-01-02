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
    
    private var type: NavigationBarType = .normal
    
    private lazy var backArrowButton = UIButton().then {
        $0.setImage(ImageLiterals.NavigationBar.icArrowLeft, for: .normal)
        $0.isHidden = true
    }
    
    private lazy var pointButton = UIButton().then {
        $0.backgroundColor = .blue
        $0.isHidden = true
    }
    
    private let logoImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.iosText3Semibold18
        $0.isHidden = true
    }
    
    init(leftItem type: NavigationBarType, isBackButton: Bool, isTitleLabel: Bool, isPointImage: Bool, titleText: String? = nil) {
        super.init(frame: .zero)
        self.type = type
        
        backArrowButton.isHidden = !isBackButton
        titleLabel.isHidden = !isTitleLabel
        pointButton.isHidden = !isPointImage
        titleLabel.text = titleText
        
        setUI()
        addTarget()
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
            self.addSubviews(backArrowButton, titleLabel, pointButton)
            
        case .logo:
            self.addSubviews(logoImageView)
        }
    }
    
    private func setConstraints() {
        switch type {
        case .normal:
            backArrowButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(20.adjusted)
                $0.size.equalTo(24.adjusted)
            }
            
            titleLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            
            pointButton.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(20.adjusted)
                $0.size.equalTo(24.adjusted)
            }
            
        case .logo:
            logoImageView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(20.adjusted)
                $0.size.equalTo(24.adjusted)
            }
        }
    }
    
    private func addTarget() {
        backArrowButton.addTarget(self, action: #selector(backArrowButtonTapped), for: .touchUpInside)
    }
    
    
    @objc private func backArrowButtonTapped() {
        guard let navigationController = findViewController()?.navigationController else {
            return
        }
        navigationController.popViewController(animated: true)
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
}

