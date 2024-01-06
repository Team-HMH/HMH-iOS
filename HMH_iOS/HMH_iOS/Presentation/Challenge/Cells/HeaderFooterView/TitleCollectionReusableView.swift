//
//  TitleCollectionReusableView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

class TitleCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "TitleCollectionReusableView"
    
    private let subTitleLabel = UILabel().then {
        $0.text = "목표 이용시간"
        $0.font = .iosText5Medium16
        $0.textColor = .gray1
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "3시간"
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
        subTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.leading.equalToSuperview().offset(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(30)
        }
    }
    
}
