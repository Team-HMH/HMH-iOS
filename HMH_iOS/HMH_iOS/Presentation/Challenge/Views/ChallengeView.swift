//
//  ChallengeView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class ChallengeView: UIView {
    
    private let goalTime: Int = 3
    private var days: Int = 14
    private let appList: [AppModel] = [AppModel(appIcon: "", appName: "Instagram", appUseTime: "1시간 20분"),
                                       AppModel(appIcon: "", appName: "Youtube", appUseTime: "1시간")]
    
    lazy var challengeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .background
        $0.collectionViewLayout = createLayout()
        
        $0.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.identifer)
        $0.register(AppListCollectionViewCell.self, forCellWithReuseIdentifier: AppListCollectionViewCell.identifer)
        
        $0.register(TitleCollectionReusableView.self, forSupplementaryViewOfKind: StringLiteral.Challenge.Idetifier.titleHeaderViewId, 
                    withReuseIdentifier: TitleCollectionReusableView.identifier)
        $0.register(AppCollectionReusableView.self, forSupplementaryViewOfKind: StringLiteral.Challenge.Idetifier.appListHeaderViewId, 
                    withReuseIdentifier: AppCollectionReusableView.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        configureView()
        configreCollectionView()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        self.addSubviews(challengeCollectionView)
        
    }
    
    func setConstraints() {
        
        challengeCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureView() {
        self.backgroundColor = .background
    }
    
    func configreCollectionView() {
        challengeCollectionView.dataSource = self
    }
    
    func addTarget() {
        
    }
}

extension ChallengeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return days
        case 1:
            return appList.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifer, for: indexPath)
                    as? DateCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(date: "\(1 + indexPath.item)")
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppListCollectionViewCell.identifer, for: indexPath)
                    as? AppListCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(appName: appList[indexPath.item].appName, appTime: appList[indexPath.item].appUseTime)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == StringLiteral.Challenge.Idetifier.titleHeaderViewId {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: StringLiteral.Challenge.Idetifier.titleHeaderViewId, withReuseIdentifier: TitleCollectionReusableView.identifier, for: indexPath) as? TitleCollectionReusableView else { return UICollectionReusableView() }
            return header
        } else if kind == StringLiteral.Challenge.Idetifier.appListHeaderViewId {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: StringLiteral.Challenge.Idetifier.appListHeaderViewId, withReuseIdentifier: AppCollectionReusableView.identifier, for: indexPath) as? AppCollectionReusableView else { return UICollectionReusableView() }
            return header
        } else {
            return UICollectionReusableView()
        }
    }
}


extension ChallengeView {
    func createDateLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(40),
                                              heightDimension: .absolute(63))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(63))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 7)
        group.interItemSpacing = .fixed(7)
        group.contentInsets = .init(top: 0, leading: 27.adjustedWidth, bottom: 0, trailing: 27.adjustedWidth)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 19
        section.contentInsets = .init(top: 0, leading: 0, bottom: 35, trailing:0)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(145.adjustedHeight))
        
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: StringLiteral.Challenge.Idetifier.titleHeaderViewId,
                                                                        alignment: .topLeading)
        section.boundarySupplementaryItems = [headerElement]
        
        // Background
        let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: StringLiteral.Challenge.Idetifier.backgroundViewId)
        section.decorationItems = [sectionBackgroundDecoration]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.register(GrayBackgroundView.self, 
                        forDecorationViewOfKind: StringLiteral.Challenge.Idetifier.backgroundViewId)
        
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
    
    func createAppListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(68))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(7)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(64.adjustedHeight))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind:StringLiteral.Challenge.Idetifier.appListHeaderViewId,
                                                                        alignment: .topLeading)
        section.boundarySupplementaryItems = [headerElement]
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0: return self?.createDateLayout()
            case 1: return self?.createAppListLayout()
            default: return nil
            }
        }
        
        // Register decoration view
        layout.register(GrayBackgroundView.self,
                        forDecorationViewOfKind: StringLiteral.Challenge.Idetifier.backgroundViewId)
        
        return layout
    }
}
