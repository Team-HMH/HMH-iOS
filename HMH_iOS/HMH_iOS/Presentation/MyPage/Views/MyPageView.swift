//
//  MyPageView.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/8/24.
//

import UIKit

import SnapKit
import Then

final class MyPageView: UIView {
    lazy var myPageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .gray8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        self.addSubviews(myPageCollectionView)
        
    }
    
    func setConstraints() {
        myPageCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
