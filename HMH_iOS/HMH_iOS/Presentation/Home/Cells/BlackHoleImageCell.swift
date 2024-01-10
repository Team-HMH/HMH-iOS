//
//  BlackHoleImageCell.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class BlackHoleImageCell: UICollectionViewCell {
    
    static let identifier = "BlackHoleImageCell"
    
    private let blackHoleImageView = UIImageView().then {
        $0.image = ImageLiterals.TabBar.icHome
        $0.alpha = 0.1
    }
    private let homeBlackHoleStateLabel = UILabel().then {
        $0.font = .iosTitle3Semibold22
        $0.textColor = .whiteText
        $0.setTextWithLineHeight(text: StringLiteral.Home.blackHoleState, lineHeight: 33)
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubviews(blackHoleImageView, homeBlackHoleStateLabel)
    }
    
    private func setConstraints() {
        blackHoleImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(blackHoleImageView.snp.width)
        }
        
        homeBlackHoleStateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23.adjusted)
            $0.leading.equalToSuperview().inset(21.adjusted)
        }
    }
}
