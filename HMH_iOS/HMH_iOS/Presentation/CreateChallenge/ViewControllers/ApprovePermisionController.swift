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
    let userNotiCenter = UNUserNotificationCenter.current()
    var isApproveScreenTime = false
    var isApproveNoti = false
    
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
        userNotiCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { didAllow, error in
            if didAllow {
                self.isApproveNoti = true
            } else {
                self.isApproveNoti = false
            }
        })
    }
}

extension ApprovePermisionController: NextViewPushDelegate {
    func didTapButton() {
        requestAuthNoti()
        requestPermission { isScreenTimeApproved in
            if self.isApproveNoti && isScreenTimeApproved {
                self.navigationController?.pushViewController(AppSelectViewController(), animated: false)
            } else if self.isApproveNoti == false {
                self.view.showToast(message: "알림 권한 설정이 필요해요!", at: 30.adjustedHeight)
            } else if isScreenTimeApproved == false {
                self.view.showToast(message: "스크린타임 설정이 필요해요!", at: 30.adjustedHeight)
            }
        }
    }
}
