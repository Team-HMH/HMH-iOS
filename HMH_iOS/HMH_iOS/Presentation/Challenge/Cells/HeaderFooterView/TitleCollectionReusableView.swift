//
//  TitleCollectionReusableView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class TitleCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "TitleCollectionReusableView"
    
    var isButtonTapped = false
    
    private let subTitleLabel = UILabel().then {
        $0.text = StringLiteral.Challenge.Date.dateHeaderSubTitle
        $0.font = .iosText5Medium16
        $0.textColor = .gray1
    }
    
    private let titleLabel = UILabel().then {
        $0.text = StringLiteral.Challenge.Date.dateHeaderTitle
        $0.font = .iosTitle1Semibold32
        $0.textColor = .whiteText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        self.addSubviews(titleLabel, subTitleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(29.adjustedWidth)
            $0.bottom.equalToSuperview().inset(26.adjusted)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-9.adjusted)
        }
    }
    
    @objc func deleteButtonDidTapped() {
        if isButtonTapped {
            
        } else {
            
        }
        isButtonTapped.toggle()
    }
    
}
