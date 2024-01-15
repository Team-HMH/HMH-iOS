//
//  GoalTimeSelectViewController.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/9/24.
//
//

import UIKit

import SnapKit
import Then

final class GoalTimeSelectViewController: OnboardingBaseViewController {
    
    private let goalTimeView = GoalTimeSelectView()
    
    override func loadView() {
        self.view = goalTimeView
    }
    
    override func viewDidLoad() {
        configureViewController()
        
        super.viewDidLoad()
    }
    
    private func configureViewController() {
        mainTitleText = StringLiteral.Challenge.GoalTime.titleText
        subTitleText = StringLiteral.Challenge.GoalTime.subTitleText
        nextButton.setTitle("완료", for: .normal)
        step = 6
    }
    
    override func onTapButton() {
        let rootViewController = TabBarController()
        rootViewController.selectedIndex = 0
        self.setRootViewController(rootViewController)
        
    }
    
}
