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
        self.addSubview(grayBackgroundView)
    }
    
    private func setConstraints() {
        grayBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(-200)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
