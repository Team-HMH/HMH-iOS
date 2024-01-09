//
//  StoreCollectionViewCell.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class StoreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StoreCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
