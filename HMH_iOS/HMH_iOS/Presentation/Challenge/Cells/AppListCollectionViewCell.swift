//
//  AppListCollectionViewCell.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

class AppListCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "AppListCollectionViewCell"
    
    let appImageView = UIImageView().then {
        $0.backgroundColor = .blue
        $0.makeCornerRound(radius: 8)
    }
    
    let appIconLabel = UILabel().then {
        $0.text = "instagram"
        $0.textColor = .systemGray4
        $0.font = .systemFont(ofSize: 14)
    }
    
    let timeLabel = UILabel().then {
        $0.text = "1시간 30분"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .systemGray
        contentView.makeCornerRound(radius: 6)
        contentView.addSubviews(backView,appImageView, appIconLabel, timeLabel)
    }
    
    private func setConstraints() {
        
        appImageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.leading.equalToSuperview().offset(17)
            $0.centerY.equalToSuperview()
        }
        
        appIconLabel.snp.makeConstraints {
            $0.leading.equalTo(appImageView.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(27)
            $0.centerY.equalToSuperview()
        }
        
    }

}
