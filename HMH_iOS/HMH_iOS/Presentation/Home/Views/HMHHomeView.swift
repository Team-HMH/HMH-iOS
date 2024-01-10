//
//  HMHHomeView.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class HMHHomeView: UIView {
    private let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        configureView()
        setRegister()
        configreCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubview(homeCollectionView)
    }
    
    private func setConstraints() {
        homeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureView() {
        self.backgroundColor = .background
    }
    
    private func setRegister() {
        homeCollectionView.register(BlackHoleImageCell.self, forCellWithReuseIdentifier: BlackHoleImageCell.identifier)
        homeCollectionView.register(MyGoalTimeCell.self, forCellWithReuseIdentifier: MyGoalTimeCell.identifier)
        homeCollectionView.register(AppUsingProgressViewCell.self, forCellWithReuseIdentifier: AppUsingProgressViewCell.identifier)
    }
    
    private func configreCollectionView() {
        homeCollectionView.showsVerticalScrollIndicator = false
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
}

extension HMHHomeView: UICollectionViewDelegate {}

extension HMHHomeView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return appUsingTimeModel.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let item = homeCollectionView.dequeueReusableCell(withReuseIdentifier: BlackHoleImageCell.identifier, for: indexPath) as? BlackHoleImageCell else { return UICollectionViewCell() }
            return item
            
        case 1:
            guard let item = homeCollectionView.dequeueReusableCell(withReuseIdentifier: MyGoalTimeCell.identifier, for: indexPath) as? MyGoalTimeCell else { return UICollectionViewCell() }
            item.bindData(data: appUsingTimeModel)
            return item
            
        case 2:
            guard let item = homeCollectionView.dequeueReusableCell(withReuseIdentifier: AppUsingProgressViewCell.identifier, for: indexPath) as? AppUsingProgressViewCell else { return UICollectionViewCell() }
            item.bindData(data: appUsingTimeModel[indexPath.row])
            return item
        default:
            return UICollectionViewCell()
        }
    }
}

extension HMHHomeView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
        case 1:
            let itemWidthOrHeight: CGFloat = 90
            return CGSize(width: collectionView.frame.width, height: itemWidthOrHeight.adjusted)
        case 2:
            let itemWidthOrHeight: CGFloat = 80
            return CGSize(width: collectionView.frame.width, height: itemWidthOrHeight.adjusted)
        default:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 1:
            return UIEdgeInsets(top: -25.adjusted, left: 0, bottom: 16.adjusted, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
