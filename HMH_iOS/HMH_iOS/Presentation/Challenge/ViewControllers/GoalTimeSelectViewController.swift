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
    private var specificTime: Int = 0
    private var specificMinute: Int = 0
    
    override func loadView() {
        self.view = goalTimeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setDelegate()
    }
    
    private func configureViewController() {
        mainTitleText = StringLiteral.Challenge.GoalTime.titleText
        subTitleText = StringLiteral.Challenge.GoalTime.subTitleText
        nextButton.setTitle("완료", for: .normal)
        step = 6
    }
    
    private func setDelegate() {
        self.delegate = self
        goalTimeView.hourPicker.totalTimePickerDelegate = self
        goalTimeView.minPicker.totalTimePickerDelegate = self
    }
    
    override func onTapButton() {
        let rootViewController = TabBarController()
        rootViewController.selectedIndex = 0
        self.setRootViewController(rootViewController)
    }
}

extension GoalTimeSelectViewController: TimePickerDelegate {
    func updateAvailability(selectedValue: Int, type: HMHTimePickerView.TimePickerType) {
        if type == .specificTime {
            self.specificTime = selectedValue
            
        } else if type == .specificMinute {
            self.specificMinute = selectedValue
        }
        nextButton.updateStatus(isEnabled: true)
        let convertedTime = convertHoursAndMinutesToMilliseconds(hours: specificTime, minutes: specificMinute)
        SignUpManager.shared.goalTime = convertedTime
    }
}

extension GoalTimeSelectViewController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = ApprovePermisionController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
}

