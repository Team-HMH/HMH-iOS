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
        myPageCollectionView.register(StoreCollectionViewCell.self, forCellWithReuseIdentifier: StoreCollectionViewCell.identifier)
        myPageCollectionView.register(InfoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderView.identifier)
        myPageCollectionView.register(LogoutAndQuitFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LogoutAndQuitFooterView.identifier)
    }
    
    private func configreCollectionView() {
        myPageCollectionView.showsVerticalScrollIndicator = false
        myPageCollectionView.delegate = self
        myPageCollectionView.dataSource = self
    }
    
    private func openWebLink(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension MyPageView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            if indexPath.item == 0 {
                openWebLink(StringLiteral.myPage.urlArray[0])
            } else if indexPath.item == 1 {
                openWebLink(StringLiteral.myPage.urlArray[1])
            }
        default:
            break
        }
    }
}

extension MyPageView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
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
            guard let item = myPageCollectionView.dequeueReusableCell(withReuseIdentifier: StoreCollectionViewCell.identifier, for: indexPath) as? StoreCollectionViewCell else {return UICollectionViewCell()}
            return item
        case 2:
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
        case 1:
            let itemWidthOrHeight: CGFloat = 8
            return CGSize(width: collectionView.frame.width, height: itemWidthOrHeight.adjusted)
        default:
            let itemWidthOrHeight: CGFloat = 60
            return CGSize(width: collectionView.frame.width, height: itemWidthOrHeight.adjusted)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 1:
            return UIEdgeInsets(top: 0, left: 0, bottom: 10.adjusted, right: 0)
        default:
            return UIEdgeInsets.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UserPointHeaderView.identifier, for: indexPath) as? UserPointHeaderView else {
                    return UICollectionReusableView()
                }
                headerView.getUserDataAPI()
                return headerView
            }
        case 2:
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoHeaderView.identifier, for: indexPath) as? InfoHeaderView else {
                    return UICollectionReusableView()
                }
                return headerView
            } else if kind == UICollectionView.elementKindSectionFooter {
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
            return .init(width: UIScreen.main.bounds.width, height: 198.adjusted)
        } else if section == 2 {
            return .init(width: UIScreen.main.bounds.width, height: 64.adjusted)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 2 {
            return .init(width: UIScreen.main.bounds.width, height: 87.adjusted)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
