//
//  ChanllengeViewController.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/3/24.
//

import UIKit

import SnapKit
import Then

final class ChallengeViewController: UIViewController {
    
    private let navigationBar = HMHNavigationBar(leftItem: .normal,
                                                 isBackButton: false,
                                                 isTitleLabel: true,
                                                 isPointImage: true,
                                                 isBackGroundGray: true,
                                                 titleText: StringLiteral.Challenge.NavigationBarTitle)
    private let challengeView = ChallengeView()
    
    override func loadView() {
        self.view = challengeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(navigationBar)
    }
    
    private func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
}
