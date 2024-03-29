//
//  ChallengeView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit
import SwiftUI

import SnapKit
import Then
import FamilyControls

final class ChallengeView: UIView {
    private var appAddButtonViewModel: BlockingApplicationModel = BlockingApplicationModel.shared
    var challengeType: ChallengeType  = ChallengeManager.shared.type {
        didSet {
            challengeCollectionView.reloadData()
        }
    }
    
    var goalTimeHour: Int = 3
    var days: Int = 0
    var appList: [App] = [] {
        didSet {
            challengeCollectionView.reloadData()
        }
    }
    var dailyStatus: [String] = []
    var todayIndex = 0
    var isCompleted = false 
    
    var isDeleteMode: Bool = false {
        didSet {
            challengeCollectionView.reloadData()
        }
    }
    
    private var token = BlockingApplicationModel.shared.selectedAppsTokens {
        didSet {
            challengeCollectionView.reloadData()
        }
    }
    
    lazy var challengeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .background
        $0.collectionViewLayout = createLayout()
        $0.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    init(frame: CGRect, appAddButtonViewModel: BlockingApplicationModel) {
        self.appAddButtonViewModel = appAddButtonViewModel
        super.init(frame: frame)
        
        setUI()
        setRegister()
        configureView()
        configreCollectionView()
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
    
    func setRegister() {
        challengeCollectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.identifer)
        challengeCollectionView.register(AppListCollectionViewCell.self,
                                         forCellWithReuseIdentifier: AppListCollectionViewCell.identifer)
        
        challengeCollectionView.register(TitleCollectionReusableView.self,
                                         forSupplementaryViewOfKind: StringLiteral.Challenge.Idetifier.titleHeaderViewId,
                                         withReuseIdentifier: TitleCollectionReusableView.identifier)
        challengeCollectionView.register(AppCollectionReusableView.self,
                                         forSupplementaryViewOfKind: StringLiteral.Challenge.Idetifier.appListHeaderViewId,
                                         withReuseIdentifier: AppCollectionReusableView.identifier)
        challengeCollectionView.register(AppAddCollectionReusableView.self,
                                         forSupplementaryViewOfKind: StringLiteral.Challenge.Idetifier.appAddFooterViewID,
                                         withReuseIdentifier: AppAddCollectionReusableView.identifier)
    }
    
    func configureView() {
        self.backgroundColor = .background
    }
    
    func configreCollectionView() {
        challengeCollectionView.dataSource = self
        challengeCollectionView.allowsMultipleSelection = true
        self.challengeCollectionView.reloadData()
        
    }
    
    @objc private func deleteButtonTapped() {
        isDeleteMode.toggle()
    }
    
    @objc func onTapButton() {
        if let challengeViewController = self.getChallengeViewController() {
            challengeViewController.onTabButton()
        }
    }
    
    
    func deleteCell() {
        print("tap")
    }

}

extension ChallengeView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            if ChallengeManager.shared.type == .completed { return 0 }
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
            
            var image = ImageLiterals.Challenge.icUnselected
            
            switch dailyStatus[indexPath.row]{
            case "UNEARNED":
                image = ImageLiterals.Challenge.icChallengeSuccess
            case "FAILURE", "EARNED":
                image = ImageLiterals.Challenge.icChallengeFail
            default:
                image = ImageLiterals.Challenge.icUnselected
            }
            cell.configureCell(date: "\(1 + indexPath.item)", image: image)
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppListCollectionViewCell.identifer, for: indexPath)
                    as? AppListCollectionViewCell else {
                return UICollectionViewCell()
            }
            if isDeleteMode {
                if indexPath.item == 0 {
                    cell.isSelectedCell = true
                }
                else {
                    cell.isSelectedCell = false
                }
            } else {
                cell.isSelectedCell = false
            }
            let appGoalHour = convertMillisecondsToHoursAndMinutes(milliseconds: appList[indexPath.item].usageTime).hours
            let appGoalMin = convertMillisecondsToHoursAndMinutes(milliseconds: appList[indexPath.item].usageTime).minutes
            let appTimeString = appGoalHour<=0 ? "\(appGoalMin)분" : "\(appGoalHour)시간 \(appGoalMin)분"
            print(appTimeString)
            cell.configureCell(appName: appList[indexPath.item].appName, appTime: appTimeString)
            cell.appImageView.kfSetImage(url: appList[indexPath.item].appImageURL)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == StringLiteral.Challenge.Idetifier.titleHeaderViewId {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: StringLiteral.Challenge.Idetifier.titleHeaderViewId, withReuseIdentifier: TitleCollectionReusableView.identifier, for: indexPath) as? TitleCollectionReusableView
            else { return UICollectionReusableView() }
            
            let goalTime =  convertMillisecondsToHoursAndMinutes(milliseconds: goalTimeHour).hours
            header.configureTitle(hour: goalTime)
            header.backgroundType = ChallengeManager.shared.type
            header.button.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
            return header
        } else if kind == StringLiteral.Challenge.Idetifier.appListHeaderViewId {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: StringLiteral.Challenge.Idetifier.appListHeaderViewId, withReuseIdentifier: AppCollectionReusableView.identifier, for: indexPath) as? AppCollectionReusableView {
                header.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
                header.isDeleteMode = isDeleteMode
                return header
            }
            else { return UICollectionReusableView() }
        } else if kind == StringLiteral.Challenge.Idetifier.appAddFooterViewID {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: StringLiteral.Challenge.Idetifier.appAddFooterViewID, withReuseIdentifier: AppAddCollectionReusableView.identifier, for: indexPath) as? AppAddCollectionReusableView
            else { return UICollectionReusableView() }
            return footer
        } else {
            return UICollectionReusableView()
        }
    }
}


extension ChallengeView {
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(40),
                                                      heightDimension: .absolute(63))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(63))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               repeatingSubitem: item,
                                                               count: 7)
                let groupInset = (environment.container.contentSize.width - 322) / 2
                group.contentInsets = .init(top: 0, leading: groupInset, bottom: 0, trailing: groupInset)
                group.interItemSpacing = .fixed(7)
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 16
                section.contentInsets = .init(top: 0, leading: 0, bottom: 35, trailing:0)
                
                let headerHeight =                
                switch ChallengeManager.shared.type {
                case .sevenDays, .fourteenDays:
                    115
                case .completed:
                    263
                }
                
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(CGFloat(headerHeight)))
                
                let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind: StringLiteral.Challenge.Idetifier.titleHeaderViewId,
                                                                                alignment: .topLeading)
                section.boundarySupplementaryItems = [headerElement]
                
                let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: StringLiteral.Challenge.Idetifier.backgroundViewId)
                
                section.decorationItems = [sectionBackgroundDecoration]
                
                let layout = UICollectionViewCompositionalLayout(section: section)
                layout.register(GrayBackgroundView.self, forDecorationViewOfKind: StringLiteral.Challenge.Idetifier.backgroundViewId)
                
                
                section.orthogonalScrollingBehavior = .none
                
                return section
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(68))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(CGFloat((68 + 7) * self.appList.count)))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(7)
                
                let section = NSCollectionLayoutSection(group: group)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(64))
                let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                                elementKind:StringLiteral.Challenge.Idetifier.appListHeaderViewId,
                                                                                alignment: .topLeading)
                
                let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(68))
                let footerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                                elementKind:StringLiteral.Challenge.Idetifier.appAddFooterViewID,
                                                                                alignment: .bottomLeading)
                
                section.boundarySupplementaryItems = [headerElement, footerElement]
                section.orthogonalScrollingBehavior = .none
                
                return section
            default: return nil
            }
        }
        layout.register(GrayBackgroundView.self,
                        forDecorationViewOfKind: StringLiteral.Challenge.Idetifier.backgroundViewId)
        
        return layout
    }
}

extension ChallengeView {
    func getChallengeViewController() -> ChallengeViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? ChallengeViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
