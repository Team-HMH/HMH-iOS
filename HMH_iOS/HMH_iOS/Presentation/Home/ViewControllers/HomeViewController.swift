//
//  HomeViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 12/23/23.
//

import UIKit

final class HomeViewController: UIViewController {
     
    private let homeView = HMHHomeView()
    let provider = Providers.challengeProvider
    var app: [App] = [] {
        didSet{
            homeView.homeCollectionView.reloadData()
        }
    }
    var data: GetDummyResponseDTO = GetDummyResponseDTO(apps: []) {
        didSet{
            homeView.homeCollectionView.reloadData()
        }
    }
    
    var totalAppUsingTimeData: TotalAppUsingTimeDataModel = .init(
        onboardingTotalGoalTime: 0,
        totalAppRemainedTime: 0,
        isFailed: false) {
            didSet {
                homeView.homeCollectionView.reloadSections([1, 0])
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestPermision()
        LoadTodayChallenge()
        getDummyDataAPI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configreCollectionView()
//        
//        //        // 영상 로딩을 위한 애니메이션 코드
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                    self.totalAppUsingTimeData.totalAppRemainedTime += 0.4
////                    self.totalAppUsingTimeData.isFailed = true
//                }
    }
    
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(homeView)
    }
    
    private func setConstraints() {
        
        homeView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    private func LoadTodayChallenge() {
        provider.request(target: .getdailyChallenge, instance: BaseResponse<EmptyResponseDTO>.self, viewController: self) { result in
            print(result.status)
        }
    }
    
    private func configreCollectionView() {
        homeView.homeCollectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
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
            return app.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let blackholeImageCell = homeView.homeCollectionView.dequeueReusableCell(withReuseIdentifier: BlackHoleImageCell.identifier, for: indexPath) as? BlackHoleImageCell else { return UICollectionViewCell() }
        guard let myGoalTimeCell = homeView.homeCollectionView.dequeueReusableCell(withReuseIdentifier: MyGoalTimeCell.identifier, for: indexPath) as? MyGoalTimeCell else { return UICollectionViewCell() }
        guard let appUsingProgressViewCell = homeView.homeCollectionView.dequeueReusableCell(withReuseIdentifier: AppUsingProgressViewCell.identifier, for: indexPath) as? AppUsingProgressViewCell else { return UICollectionViewCell() }
        myGoalTimeCell.bindData(data: data)
        
        switch indexPath.section {
        case 0:
            if totalAppUsingTimeData.isFailed {
                blackholeImageCell.configureCell(
                    image: blackHoleModel[BlackHoleDataType.fail.rawValue].image,
                    videoUrl: blackHoleModel[BlackHoleDataType.fail.rawValue].videoItem,
                    text: blackHoleModel[BlackHoleDataType.fail.rawValue].text
                )
            } else {
                if totalAppUsingTimeData.totalAppRemainedTime < 0.25 && totalAppUsingTimeData.totalAppRemainedTime > 0 {
                    blackholeImageCell.configureCell(
                        image: blackHoleModel[BlackHoleDataType.firstStep.rawValue].image,
                        videoUrl: blackHoleModel[BlackHoleDataType.firstStep.rawValue].videoItem,
                        text: blackHoleModel[BlackHoleDataType.firstStep.rawValue].text)
                } else if totalAppUsingTimeData.totalAppRemainedTime < 0.5 && totalAppUsingTimeData.totalAppRemainedTime > 0.24 {
                    blackholeImageCell.configureCell(
                        image: blackHoleModel[BlackHoleDataType.secondStep.rawValue].image,
                        videoUrl: blackHoleModel[BlackHoleDataType.secondStep.rawValue].videoItem,
                        text: blackHoleModel[BlackHoleDataType.secondStep.rawValue].text)
                } else if totalAppUsingTimeData.totalAppRemainedTime < 0.75 && totalAppUsingTimeData.totalAppRemainedTime > 0.49 {
                    blackholeImageCell.configureCell(
                        image: blackHoleModel[BlackHoleDataType.thirdStep.rawValue].image,
                        videoUrl: blackHoleModel[BlackHoleDataType.thirdStep.rawValue].videoItem,
                        text: blackHoleModel[BlackHoleDataType.thirdStep.rawValue].text)
                } else if totalAppUsingTimeData.totalAppRemainedTime < 1.0 && totalAppUsingTimeData.totalAppRemainedTime > 0.74 {
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
            myGoalTimeCell.LoadTodayChallenge()
            return myGoalTimeCell
            
        case 2:
            appUsingProgressViewCell.bindData(data: app[indexPath.item])
            return appUsingProgressViewCell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController {
    func getDummyDataAPI() {
        provider.request(target: .getDummyData,
                         instance: BaseResponse<GetDummyResponseDTO>.self,
                         viewController: HomeViewController()) { data in
            guard let data = data.data else { return }
            self.app = data.apps
            self.data = data
        }
    }
}
