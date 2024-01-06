//
//  GrayBackgroundView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

class GrayBackgroundView: UICollectionReusableView {
    private let grayBackgroundView = UIView().then {
        $0.backgroundColor = .gray7 //UIColor(red: 246, green: 247, blue: 251)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(grayBackgroundView)

        grayBackgroundView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(-100)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
