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
    private var isGray: Bool = false
    
    private lazy var backArrowButton = UIButton().then {
        $0.setImage(ImageLiterals.NavigationBar.icArrowLeft, for: .normal)
        $0.isHidden = true
    }
    
    private lazy var pointButton = UIButton().then {
        $0.isHidden = true
    }
    
    private let pointImageView = UIImageView().then {
        $0.image = ImageLiterals.NavigationBar.icPoint
        $0.tintColor = .gray3
    }
    
    private let logoImageView = UIImageView().then {
        $0.backgroundColor = .blue
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.iosText3Semibold18
        $0.isHidden = true
    }
    
    init(leftItem type: NavigationBarType,
         isBackButton: Bool,
         isTitleLabel: Bool,
         isPointImage: Bool,
         isBackGroundGray: Bool,
         titleText: String? = nil) {
        super.init(frame: .zero)
        self.type = type
        
        backArrowButton.isHidden = !isBackButton
        titleLabel.isHidden = !isTitleLabel
        pointButton.isHidden = !isPointImage
        isGray = isBackGroundGray
        titleLabel.text = titleText
        
        setUI()
        addTarget()
        configureNavigationBar()
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
            pointButton.addSubview(pointImageView)
        case .logo:
            self.addSubviews(logoImageView)
        }
    }
    
    private func setConstraints() {
        //SE이외의 기기 일때
        if UIScreen.main.isLongerThan812pt {
            self.snp.makeConstraints {
                $0.height.equalTo(113.adjusted)
            }
            switch type {
            case .normal:
                backArrowButton.snp.makeConstraints {
                    $0.centerY.equalTo(titleLabel)
                    $0.leading.equalToSuperview().inset(20.adjusted)
                    $0.size.equalTo(24.adjusted)
                }
                
                titleLabel.snp.makeConstraints {
                    $0.top.equalToSuperview().offset(68.adjusted)
                    $0.centerX.equalToSuperview()
                }
                
                pointButton.snp.makeConstraints {
                    $0.centerY.equalTo(titleLabel)
                    $0.trailing.equalToSuperview().inset(20.adjusted)
                    $0.size.equalTo(24.adjusted)
                }
                
                pointImageView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
                
            case .logo:
                logoImageView.snp.makeConstraints {
                    $0.centerY.equalToSuperview().offset(50.adjusted)
                    $0.leading.equalToSuperview().inset(20.adjusted)
                    $0.size.equalTo(24.adjusted)
                }
            }
        } else {
            self.snp.makeConstraints {
                $0.height.equalTo(83.adjusted)
            }
            switch type {
            case .normal:
                backArrowButton.snp.makeConstraints {
                    $0.centerY.equalTo(titleLabel)
                    $0.leading.equalToSuperview().inset(20.adjusted)
                    $0.size.equalTo(24.adjusted)
                }
                
                titleLabel.snp.makeConstraints {
                    $0.centerX.equalToSuperview()
                    $0.bottom.equalToSuperview().offset(-18.adjusted)
                }
                
                pointButton.snp.makeConstraints {
                    $0.centerY.equalTo(titleLabel)
                    $0.trailing.equalToSuperview().inset(20.adjusted)
                    $0.size.equalTo(24.adjusted)
                }
                
                pointImageView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            case .logo:
                logoImageView.snp.makeConstraints {
                    $0.centerY.equalToSuperview().offset(50.adjusted)
                    $0.leading.equalToSuperview().inset(20.adjusted)
                    $0.size.equalTo(24.adjusted)
                }
            }
        }
    }
    
    private func addTarget() {
        backArrowButton.addTarget(self, action: #selector(backArrowButtonTapped), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        self.backgroundColor = isGray ? .gray7 : .background
    }
    
    @objc private func backArrowButtonTapped() {
        guard let navigationController = findViewController()?.navigationController else {
            return
        }
        navigationController.popViewController(animated: false)
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

