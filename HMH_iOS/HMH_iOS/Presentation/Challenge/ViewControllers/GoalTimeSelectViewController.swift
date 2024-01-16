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
        configureViewController()
        self.delegate = self
        goalTimeView.hourPicker.totalTimePickerDelegate = self
        goalTimeView.minPicker.totalTimePickerDelegate = self

        super.viewDidLoad()
    }
    
    private func configureViewController() {
        mainTitleText = StringLiteral.Challenge.GoalTime.titleText
        subTitleText = StringLiteral.Challenge.GoalTime.subTitleText
        nextButton.setTitle("완료", for: .normal)
        step = 6
    }
    
    override func onTapButton() {
        self.navigationController?.popToRootViewController(animated: false)
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
        //변환 함수 실행
        print(specificTime, specificMinute, "시간 분 😂")
    }
}

extension GoalTimeSelectViewController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = ApprovePermisionController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
}

