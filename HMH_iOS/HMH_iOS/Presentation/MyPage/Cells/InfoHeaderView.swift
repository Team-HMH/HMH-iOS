//
//  InfoHeaderView.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class InfoHeaderView: UICollectionReusableView {
    
    static let identifier = "InfoHeaderView"
    
    private let infoLabel = UILabel().then {
        $0.font = .iosText4Semibold16
        $0.textColor = .gray2
        $0.text = StringLiteral.myPage.info
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubview(infoLabel)
    }
    
    private func setConstraints() {
        infoLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-11.adjusted)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    private func configureView() {
        self.backgroundColor = .background
    }
}
