//
//  ChanllengeViewController.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/3/24.
//

import UIKit
import Combine

import SnapKit
import Then
import FamilyControls
import DeviceActivity

final class ChallengeViewController: UIViewController {
    var isCreatedChallenge = false
    var decodedIndex: Int = 0
    func updateChallengeStatus(isCreatedChallenge: Bool) {
        self.isCreatedChallenge = isCreatedChallenge
        configureTabBar(isCreatedChallenge: isCreatedChallenge)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    // Used to encode codable to UserDefaults
    private let encoder = PropertyListEncoder()
    
    // Used to decode codable from UserDefaults
    private let decoder = PropertyListDecoder()
    private let model = BlockingApplicationModel.shared
    
    private let navigationBar = HMHNavigationBar(leftItem: .normal,
                                                 isBackButton: false,
                                                 isTitleLabel: true,
                                                 isPointImage: true,
                                                 isBackGroundGray: true,
                                                 titleText: StringLiteral.Challenge.NavigationBarTitle)
    
    let challengeView = ChallengeView(frame: .zero, appAddButtonViewModel: BlockingApplicationModel.shared)
    
    var selectedIndex = IndexPath()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadChallenge()
        requestPermision()
        configureTabBar(isCreatedChallenge: isCreatedChallenge)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadChallenge()
        challengeView.configreCollectionView()
        setUI()
        setDelegate()
    }
    
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(navigationBar, challengeView)
    }
    
    private func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        challengeView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)                 
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureTabBar(isCreatedChallenge: Bool) {
        if isCreatedChallenge {
            let alertController = AlertViewController()
            alertController.setAlertType(.HMHChallengeAlert)
            alertController.modalPresentationStyle = .overFullScreen
            self.present(alertController, animated: false, completion: nil)
        } 
    }
    
    private func setDelegate() {
        challengeView.challengeCollectionView.delegate = self
        
    }
    
    func onTabButton() {
        let nextViewController = CreatePeriodController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
    
    func deleteTap() {
        challengeView.deleteCell()
    }
    
    func loadChallenge() {
        let provider = Providers.challengeProvider
        provider.request(target: .getChallenge, instance: BaseResponse<GetChallengeResponseDTO>.self) { data in
            if let data = data.data {
                if data.todayIndex == -1 {
                    ChallengeManager.shared.updateType(.completed)
                } else if data.period == 7 {
                    ChallengeManager.shared.updateType(.sevenDays)
                } else {
                    ChallengeManager.shared.updateType(.fourteenDays)
                }

                self.challengeView.days = data.period
                self.challengeView.goalTimeHour = data.goalTime
                self.challengeView.appList = data.apps
                self.challengeView.dailyStatus = data.statuses
                if data.todayIndex == -1 {
                    self.challengeView.challengeType = .completed
                } else if data.period == 7 {
                    self.challengeView.challengeType = .sevenDays
                } else if data.period == 14  {
                    self.challengeView.challengeType = .fourteenDays
                }
            }
            self.challengeView.challengeCollectionView.reloadData()
        }
        
        
    }
}


extension ChallengeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            if selectedIndexPath == indexPath {
                return false
            }
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.decodedIndex = indexPath.item
        print(decodedIndex)

        if selectedIndex.isEmpty {
            selectedIndex = indexPath
        }
        if challengeView.isDeleteMode {
            if let previousSelectedCell = collectionView.cellForItem(at: selectedIndex) as? AppListCollectionViewCell {
                previousSelectedCell.isSelectedCell = false
            }
            if let currentSelectedCell = collectionView.cellForItem(at: indexPath) as? AppListCollectionViewCell {
                currentSelectedCell.isSelectedCell = true

                self.selectedIndex = indexPath
                let alertController = AlertViewController()
                alertController.setAlertType(.HMHDeleteName)
                alertController.modalPresentationStyle = .overFullScreen
                self.present(alertController, animated: false, completion: nil)
            }
        }
    }
}
