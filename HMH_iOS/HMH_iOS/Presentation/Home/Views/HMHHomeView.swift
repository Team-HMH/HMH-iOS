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
    
    var totalAppUsingTimeData: TotalAppUsingTimeDataModel = .init(
        onboardingTotalGoalTime: 7200000,
        totalAppUsingTime: 1790000,
        progressValue: 0.99,
        isFailed: false) {
            didSet {
                self.homeCollectionView.reloadSections([1, 0])
            }
        }
    
    
    let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .clear
    }
    var progressPrecent: Double = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        configureView()
        setRegister()
        configreCollectionView()
        
        // 영상 로딩을 위한 애니메이션 코드
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        //                self.totalAppUsingTimeData.progressValue += 0.01
        //                self.totalAppUsingTimeData.isFailed = true
        //            }
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
        guard let blackholeImageCell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: BlackHoleImageCell.identifier, for: indexPath) as? BlackHoleImageCell else { return UICollectionViewCell() }
        guard let myGoalTimeCell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: MyGoalTimeCell.identifier, for: indexPath) as? MyGoalTimeCell else { return UICollectionViewCell() }
        guard let appUsingProgressViewCell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: AppUsingProgressViewCell.identifier, for: indexPath) as? AppUsingProgressViewCell else { return UICollectionViewCell() }
        
        myGoalTimeCell.bindData(data: totalAppUsingTimeData)
        self.progressPrecent = Double(myGoalTimeCell.progress)
        
        switch indexPath.section {
        case 0:
            if totalAppUsingTimeData.isFailed {
                blackholeImageCell.configureCell(
                    image: blackHoleModel[BlackHoleDataType.fail.rawValue].image,
                    videoUrl: blackHoleModel[BlackHoleDataType.fail.rawValue].videoItem,
                    text: blackHoleModel[BlackHoleDataType.fail.rawValue].text
                )
            } else {
                if totalAppUsingTimeData.progressValue < 0.25 && totalAppUsingTimeData.progressValue > 0 {
                    blackholeImageCell.configureCell(
                        image: blackHoleModel[BlackHoleDataType.firstStep.rawValue].image,
                        videoUrl: blackHoleModel[BlackHoleDataType.firstStep.rawValue].videoItem,
                        text: blackHoleModel[BlackHoleDataType.firstStep.rawValue].text)
                } else if totalAppUsingTimeData.progressValue < 0.5 && totalAppUsingTimeData.progressValue > 0.24 {
                    blackholeImageCell.configureCell(
                        image: blackHoleModel[BlackHoleDataType.secondStep.rawValue].image,
                        videoUrl: blackHoleModel[BlackHoleDataType.secondStep.rawValue].videoItem,
                        text: blackHoleModel[BlackHoleDataType.secondStep.rawValue].text)
                } else if totalAppUsingTimeData.progressValue < 0.75 && totalAppUsingTimeData.progressValue > 0.49 {
                    blackholeImageCell.configureCell(
                        image: blackHoleModel[BlackHoleDataType.thirdStep.rawValue].image,
                        videoUrl: blackHoleModel[BlackHoleDataType.thirdStep.rawValue].videoItem,
                        text: blackHoleModel[BlackHoleDataType.thirdStep.rawValue].text)
                } else if totalAppUsingTimeData.progressValue < 1.0 && totalAppUsingTimeData.progressValue > 0.74 {
                    blackholeImageCell.configureCell(
                        image: blackHoleModel[BlackHoleDataType.fourthStep.rawValue].image,
                        videoUrl: blackHoleModel[BlackHoleDataType.fourthStep.rawValue].videoItem,
                        text: blackHoleModel[BlackHoleDataType.fourthStep.rawValue].text)
                } else {
                    blackholeImageCell.configureCell(
                        image: blackHoleModel[BlackHoleDataType.fifthStep.rawValue].image,
                        videoUrl: blackHoleModel[BlackHoleDataType.fifthStep.rawValue].videoItem,
                        text: blackHoleModel[BlackHoleDataType.fifthStep.rawValue].text)
                }
            }
            return blackholeImageCell
            
        case 1:
            return myGoalTimeCell
            
        case 2:
            appUsingProgressViewCell.bindData(data: appUsingTimeModel[indexPath.row])
            return appUsingProgressViewCell
            
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
