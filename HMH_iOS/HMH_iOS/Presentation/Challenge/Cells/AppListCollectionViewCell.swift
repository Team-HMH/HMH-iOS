//
//  AppListCollectionViewCell.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class AppListCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "AppListCollectionViewCell"
    
    private let appImageView = UIImageView().then {
        $0.backgroundColor = .blue
        $0.makeCornerRound(radius: 8.adjusted)
    }
    
    private let appNameLabel = UILabel().then {
        $0.textColor = .gray2
        $0.font = .iosText6Medium14
    }
    
    private let timeLabel = UILabel().then {
        $0.textColor = .whiteText
        $0.font = .iosText4Semibold16
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        configureContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setUI(){
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        contentView.addSubviews(appImageView, appNameLabel, timeLabel)
    }
    
    private func setConstraints() {
        appImageView.snp.makeConstraints {
            $0.size.equalTo(40.adjusted)
            $0.leading.equalToSuperview().offset(17.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        
        appNameLabel.snp.makeConstraints {
            $0.leading.equalTo(appImageView.snp.trailing).offset(14.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(27.adjustedWidth)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    func configureContentView() {
        self.backgroundColor = .clear
        contentView.backgroundColor = .gray7
        contentView.makeCornerRound(radius: 6.adjusted)
    }
    
    func configureCell(appName: String, appIconImage: UIImage = UIImage(), appTime: String){
        self.appNameLabel.text = appName
        self.appImageView.image = appIconImage
        self.timeLabel.text = appTime
    }
}
