//
//  ApprovePermisionController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/10/24.
//

import UIKit

import SnapKit
import Then
import FamilyControls

final class ApprovePermisionController: OnboardingBaseViewController {
    private let authorizationCenter = AuthorizationCenter.shared
    private let userNotiCenter = UNUserNotificationCenter.current()
    private var isApproveScreenTime = false
    private var isApproveNoti = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSurveyView()
        setDelegate()
        nextButton.updateStatus(isEnabled: true)
        setTimeSurvey()
    }
    
    
    private func setDelegate() {
        self.delegate = self
    }
    
    private func setTimeSurvey() {
        view.backgroundColor = .background
        step = 5
        nextButton.updateStatus(isEnabled: true)
    }
    
    private func configureSurveyView() {
        nextButtonText = StringLiteral.OnboardingButton.permission
        nextButton.setButtonText(buttonTitle: nextButtonText)
        mainTitleText = StringLiteral.OnboardigMain.approvePermision
        subTitleText = StringLiteral.OnboardigSub.approvePermision
    }
    private func requestPermission(completion: @escaping (Bool) -> Void) {
        switch authorizationCenter.authorizationStatus {
        case .notDetermined:
            Task {
                do {
                    try await authorizationCenter.requestAuthorization(for: .individual)
                    if authorizationCenter.authorizationStatus == .approved {
                        completion(true)
                    } else {
                        completion(false)
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(false)
                }
            }
        case .denied:
            completion(false)
        case .approved:
            completion(true)
        @unknown default:
            self.view.showToast(message: "알 수 없는 에러가 발생했습니다.", at: 20)
            completion(false)
        }
    }
    
    func requestAuthNoti() {
        let options = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: options, completionHandler: { didAllow, error in
            if didAllow {
                self.isApproveNoti = true
            } else {
                let nowUserNotiCenter = UNUserNotificationCenter.current()
                nowUserNotiCenter.requestAuthorization(options: options) { _, _ in }
            }
        })
    }
}

extension ApprovePermisionController: NextViewPushDelegate {
    func didTapButton() {
        requestAuthNoti()
        requestPermission { isScreenTimeApproved in
            if !self.isApproveNoti {
                self.view.showToast(message: "알림 권한 설정이 필요해요!", at: 100.adjustedHeight)
                self.requestAuthNoti()
            }
            if isScreenTimeApproved {
                if !self.isApproveNoti {
                    self.view.showToast(message: "알림 권한 설정이 필요해요!", at: 100.adjustedHeight)
                    self.requestAuthNoti()
                }
                self.navigationController?.pushViewController(AppSelectViewController(), animated: false)
            } else if isScreenTimeApproved == false {
                self.view.showToast(message: "스크린타임 설정이 필요해요!", at: 100.adjustedHeight)
            }
        }
    }
}
