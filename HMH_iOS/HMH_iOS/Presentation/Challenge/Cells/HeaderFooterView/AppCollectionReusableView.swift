//
//  AppCollectionReusableView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class AppCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "AppCollectionReusableView"
    
    var isDeleteMode = false {
        didSet {
            configureButton()
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.text = StringLiteral.Challenge.AppList.appListHeaderTitle
        $0.font = .iosText5Medium16
        $0.textColor = .gray1
        $0.setTextWithLineHeight(text: $0.text, lineHeight: 24)
    }
    
    let deleteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
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
        self.addSubviews(titleLabel, deleteButton)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.adjustedWidth)
            $0.bottom.equalToSuperview().inset(17.adjustedHeight)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.adjustedWidth)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    private func configureButton() {
        if isDeleteMode{
            deleteButton.setTitle(StringLiteral.Challenge.AppList.appListCancelHeaderButtonText,
                        for: .normal)
            deleteButton.titleLabel?.font = .iosText4Semibold16
            deleteButton.setTitleColor(.gray4, for: .normal)
        } else {
            deleteButton.setTitle(StringLiteral.Challenge.AppList.appListDeleteHeaderButtonText,
                        for: .normal)
            deleteButton.titleLabel?.font = .iosText4Semibold16
            deleteButton.setTitleColor(.bluePurpleText, for: .normal)
        }
    }
    
}
