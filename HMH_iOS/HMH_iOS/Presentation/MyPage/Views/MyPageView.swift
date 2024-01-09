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
        self.addSubviews(myPageCollectionView)
    }
    
    private func setConstraints() {
        myPageCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setRegister() {
        myPageCollectionView.register(UserPointHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UserPointHeaderView.identifier)
        myPageCollectionView.register(MypageCollectionViewCell.self, forCellWithReuseIdentifier: MypageCollectionViewCell.identifier)
        myPageCollectionView.register(InfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderView.identifier)
        myPageCollectionView.register(LogoutAndQuitFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LogoutAndQuitFooterView.identifier)
    }
    
    private func configreCollectionView() {
        myPageCollectionView.delegate = self
        myPageCollectionView.dataSource = self
    }
}

extension MyPageView: UICollectionViewDelegate {}

extension MyPageView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func collectionView(_ listCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = myPageCollectionView.dequeueReusableCell(withReuseIdentifier: MypageCollectionViewCell.identifier, for: indexPath) as? MypageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch indexPath.section {
        case 0:
            if indexPath.item == 0 {
                item.configureCell(iconImage: ImageLiterals.myPage.icJourney, labelText: StringLiteral.myPage.journey, labelColor: .gray5)
            } else if indexPath.item == 1 {
                item.configureCell(iconImage: ImageLiterals.myPage.icStore, labelText: StringLiteral.myPage.store, labelColor: .gray5)
            }
            return item
            
        case 1:
            if indexPath.item == 0 {
                item.configureCell(iconImage: nil, labelText: StringLiteral.myPage.TOS, labelColor: .whiteText)
            } else if indexPath.item == 1 {
                item.configureCell(iconImage: nil, labelText: StringLiteral.myPage.privacyPolicy, labelColor: .whiteText)
            }
            return item
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension MyPageView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        default:
            let itemWidthOrHeight: CGFloat = 58
            return CGSize(width: collectionView.frame.width.adjustedWidth, height: itemWidthOrHeight.adjustedHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets.zero
        switch section {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        case 1:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            break
        }
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UserPointHeaderView.identifier, for: indexPath) as? UserPointHeaderView else {
                    return UICollectionReusableView()
                }
                headerView.bindData(model: UserModel.dummy())
                return headerView
            }
        case 1:
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else {
                    return UICollectionReusableView()
                }
                return headerView
            }
            
            else if kind == UICollectionView.elementKindSectionFooter {
                guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LogoutAndQuitFooterView.identifier, for: indexPath) as? LogoutAndQuitFooterView else {
                    return UICollectionReusableView()
                }
                return footerView
            }
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .init(width: UIScreen.main.bounds.width, height: 205.adjusted)
        } else if section == 1 {
            return .init(width: UIScreen.main.bounds.width, height: 66.adjusted)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return .init(width: UIScreen.main.bounds.width, height: 96.adjusted)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
