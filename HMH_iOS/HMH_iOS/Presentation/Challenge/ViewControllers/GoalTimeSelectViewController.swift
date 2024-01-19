//
//  GoalTimeSelectViewController.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/9/24.
//
//

import UIKit
import SwiftUI

import SnapKit
import Then

final class GoalTimeSelectViewController: OnboardingBaseViewController {
    
    private let goalTimeView = GoalTimeSelectView()
    private var specificTime: Int = 0
    private var specificMinute: Int = 0
    private var convertedTime: Int = 0
    private let model = BlockingApplicationModel.shared
    private var apps: [Apps] = []
    
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
        nextButton.updateStatus(isEnabled: true)
        step = 6
    }
    
    private func setDelegate() {
        self.delegate = self
        goalTimeView.hourPicker.totalTimePickerDelegate = self
        goalTimeView.minPicker.totalTimePickerDelegate = self
    }
    
    private func addApp() {
        ScreenTime.shared.hashValue.forEach {
            apps.append(Apps(appCode: "\($0)", goalTime: convertedTime))
        }
        
        var request: AddAppRequestDTO = .init(apps: apps)
        
        let provider = Providers.challengeProvider
        provider.request(target: .addApp(data: request), instance: BaseResponse<EmptyResponseDTO>.self,
                         completion: {_ in
            
        }) // to-do
        
        ScreenTime.shared.handleStartDeviceActivityMonitoring(interval: convertedTime)
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
        self.convertedTime = convertedTime
    }
}

extension GoalTimeSelectViewController: NextViewPushDelegate {
    func didTapButton() {
        addApp()
        ScreenTime.shared.handleStartDeviceActivityMonitoring(interval: 10)
        
        let rootViewController = TabBarController()
        rootViewController.selectedIndex = 0
        self.setRootViewController(rootViewController)
    }
}

