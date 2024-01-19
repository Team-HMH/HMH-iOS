//
//  GrayBackgroundView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class GrayBackgroundView: UICollectionReusableView {
    
    static var backgroundType: ChallengeType = ChallengeManager.shared.type
    
    private lazy var backgroundImageView = UIImageView().then {
        switch ChallengeManager.shared.type {
        case .sevenDays:
            $0.image = ImageLiterals.Challenge.icSevenDaysChallengeBackground
        case .fourteenDays:
            $0.image = ImageLiterals.Challenge.icFourteenDaysChallengeBackground
        case .completed:
            $0.image = ImageLiterals.Challenge.icAddNewChallengeBackground
        }
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
            $0.bottom.equalToSuperview().offset(-32)
            $0.top.equalToSuperview().offset(-200)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
