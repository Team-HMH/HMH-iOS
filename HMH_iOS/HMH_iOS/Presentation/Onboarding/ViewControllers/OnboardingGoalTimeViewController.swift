//
//  OnboardingGoalTimeViewController.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/15/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingGoalTimeViewController: OnboardingBaseViewController {
    
    private let onboarding = Onboarding(averageUseTime: SignUpManager.shared.averageUseTime, problem: SignUpManager.shared.problem)
    private let challenge = Challenge(period: SignUpManager.shared.period, goalTime: SignUpManager.shared.goalTime, apps: SignUpManager.shared.appCode)
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
}

extension OnboardingGoalTimeViewController: TimePickerDelegate {
    func updateAvailability(selectedValue: Int, type: HMHTimePickerView.TimePickerType) {
        if type == .specificTime {
            self.specificTime = selectedValue
            
        } else if type == .specificMinute {
            self.specificMinute = selectedValue
        }
        nextButton.updateStatus(isEnabled: true)
        //signupmanager appcode 부분 저장
        print(convertHoursAndMinutesToMilliseconds(hours: specificTime, minutes: specificMinute), "시간 분 😂")
    }
}

extension OnboardingGoalTimeViewController: NextViewPushDelegate {
    func didTapButton() {
        let request = SignUpRequestDTO(socialPlatform: "APPLE", name: UserManager.shared.fullNameValue, onboarding: onboarding, challenge: challenge)
        
        let provider = Providers.AuthProvider
        provider.request(target: .signUp(data: request), instance: BaseResponse<SignUpResponseDTO>.self, viewController: self) { data in
            if data.status == 201 {
                self.setRootViewController(SignInCompleteViewController())
                guard let data = data.data else { return }
                UserManager.shared.updateToken(data.token.accessToken, data.token.refreshToken)
                UserManager.shared.updateUserId(data.userId)
            } else {
                self.view.showToast(message: "Oops, 저희와 함께 우주로 가실 수 없습니다.", at: 100)
            }
        }
    }
}
