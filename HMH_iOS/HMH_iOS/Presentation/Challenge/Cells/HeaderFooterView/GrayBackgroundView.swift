//
//  GrayBackgroundView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

import SnapKit
import Then

enum BackgroundImage {
    case sevenDays
    case fourteenDays
    case completed
}

final class GrayBackgroundView: UICollectionReusableView {
    
    var bacgroundType: BackgroundImage?
    var isSevenDay = true
    var isCompleted = false
  
    private lazy var backgroundImageView = UIImageView().then {
        $0.image = ImageLiterals.Challenge.icAddNewChallengeBackground
    }
    
    private let grayBackgroundView = UIView().then {
        $0.backgroundColor = .gray7
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        self.addSubviews(grayBackgroundView, backgroundImageView)
    }
    
    private func setConstraints() {
        
        grayBackgroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
            $0.top.equalToSuperview().offset(-200)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(grayBackgroundView)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
