//
//  DateCollectionViewCell.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

import SnapKit
import Then

class DateCollectionViewCell: UICollectionViewCell {
    static let identifer = "DateCollectionViewCell"
    
    let dateLabel = UILabel().then {
        $0.text = "1"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    let imageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.makeCornerRound(radius: 8)
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
        contentView.addSubviews(dateLabel, imageView)
    }
    
    private func setConstraints() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
}
