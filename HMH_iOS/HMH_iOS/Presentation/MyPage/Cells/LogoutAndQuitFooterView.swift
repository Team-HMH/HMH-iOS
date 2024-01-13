//
//  LogoutAndQuitFooterView.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class LogoutAndQuitFooterView: UICollectionReusableView {
    
    static let identifier = "LogoutAndQuitFooterView"
    
    private let logoutQuitStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 19
        $0.axis = .horizontal
    }
    
    private let logoutButton = UIButton().then {
        $0.setTitle(StringLiteral.myPage.logout, for: .normal)
        $0.setTitleColor(.gray3, for: .normal)
        $0.titleLabel?.font = .iosText6Medium14
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .gray3
    }
    
    private let quitButton = UIButton().then {
        $0.setTitle(StringLiteral.myPage.quit, for: .normal)
        $0.titleLabel?.font = .iosText6Medium14
        $0.setTitleColor(.gray3, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubview(logoutQuitStackView)
        logoutQuitStackView.addArrangeSubViews([logoutButton, lineView, quitButton])
    }
    
    private func setConstraints() {
        logoutQuitStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35.adjusted)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.height.equalTo(16.adjusted)
            $0.width.equalTo(1)
        }
    }
    
    private func configureView() {
        self.backgroundColor = .background
    }
}
