//
//  UserPointHeaderView.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class UserPointHeaderView: UICollectionReusableView {
    
    static let identifier = "UserPointHeaderView"
    
    private let userStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.alignment = .center
    }
    
    private let userprofilView = UIView().then {
        $0.backgroundColor = .gray6
        $0.makeCornerRound(radius: 27)
    }
    
    private let userLabel = UILabel().then {
        $0.font = .iosTitle4Semibold20
        $0.text = "여민서"
        $0.textColor = .whiteText
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
    
    func setHierarchy() {
        self.addSubviews(userStackView)
        userStackView.addArrangeSubViews([userprofilView, userLabel])
        
    }
    
    func setConstraints() {
        userStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11.adjustedHeight)
            $0.leading.equalToSuperview().inset(20.adjustedHeight)
        }
        
        userprofilView.snp.makeConstraints {
            $0.size.equalTo(54)
        }
    }
    
    private func configureView() {
        self.backgroundColor = .background
    }
}
