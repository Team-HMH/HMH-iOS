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
        }
    })
}


func requestPermision() {
    requestAuthNoti()
    requestAuthorization()
}
