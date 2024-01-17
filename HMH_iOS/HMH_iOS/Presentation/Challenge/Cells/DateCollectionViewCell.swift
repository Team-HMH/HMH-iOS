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
    
    private let dateLabel = UILabel().then {
        $0.textColor = .gray2
        $0.font = .iosText6Medium14
    }
    
    private let imageView = UIImageView().then {
        $0.image = ImageLiterals.Challenge.icUnselected
        $0.makeCornerRound(radius: 8.adjusted)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        contentView.addSubviews(imageView, dateLabel)
    }
    
    private func setConstraints() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(6.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40.adjusted)
        }
    }
    
    func configureCell(date: String, image: UIImage = UIImage()){
        dateLabel.text = date
        imageView.image = image
    }
}
