//
//  MypageCollectionViewCell.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class MypageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MypageCollectionViewCell"
    
    private let imageAndLabelStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.alignment = .center
    }
    
    private let myPageCellIconImageView = UIImageView()
    private let myPageCellTitleLabel = UILabel().then {
        $0.font = .iosText5Medium16
        $0.textAlignment = .left
    }
    
    private let myPageCellNextPageImageView = UIImageView().then {
        $0.image = ImageLiterals.myPage.icArrowRight
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
        self.addSubviews(imageAndLabelStackView, myPageCellNextPageImageView)
        imageAndLabelStackView.addArrangeSubViews([myPageCellIconImageView, myPageCellTitleLabel])
    }
    
    private func setConstraints() {
        imageAndLabelStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        myPageCellNextPageImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configureCell(iconImage: UIImage?, labelText: String, labelColor: UIColor) {
        if let iconImage = iconImage {
            myPageCellIconImageView.image = iconImage
            myPageCellIconImageView.isHidden = false
        } else {
            myPageCellIconImageView.isHidden = true
        }
        
        myPageCellTitleLabel.text = labelText
        myPageCellTitleLabel.textColor = labelColor
    }
    
    private func configureView() {
        self.backgroundColor = .background
    }
}
