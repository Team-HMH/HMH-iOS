//
//  requestPermision.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/14/24.
//

import UIKit
import FamilyControls
import UserNotifications

let authorizationCenter = AuthorizationCenter.shared
let userNotiCenter = UNUserNotificationCenter.current()

private func requestAuthorization() {
    if !(authorizationCenter.authorizationStatus == .approved) {
        UIApplication.topViewController()?.view.showToast(message: "스크린타임 권한 설정이 필요해요!", at: 100)
        Task {
            do {
                try await authorizationCenter.requestAuthorization(for: .individual)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

func requestAuthNoti() {
    userNotiCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { didAllow, error in
        if !didAllow {
            UIApplication.topViewController()?.view.showToast(message: "푸시 알림 설정이 필요해요!", at: 100)
        }
    })
}


func requestPermision() {
    requestAuthNoti()
    requestAuthorization()
}
