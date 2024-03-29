//
//  ShieldActionExtension.swift
//  ShieldAction
//
//  Created by Yun Dongbeom on 2023/08/08.
//

import ManagedSettings
import UIKit
import SwiftUI

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
// MARK: - ShieldAction
/// 설정한 스케쥴 시간 중 FamilyActivitySelection으로 설정한 앱/웹 도메인 접근 시
/// 사용을 제한하는 Block View에서 버튼 클릭 시 동작을 작성할 수 있습니다.
class ShieldActionExtension: ShieldActionDelegate {
    
    let userNotiCenter = UNUserNotificationCenter.current()
    @AppStorage("tokenName", store: UserDefaults(suiteName: "group.65NSM7Z327.com.HMH.group")) var tokenName = "앱"
    
    
    // MARK: ApplicationToken으로 설정 된 앱에서 버튼 클릭 시 동작을 설정합니다.
    /// handle 메서드의 인자인 ShieldAction은 두 가지 case로 나누어집니다.
    ///  - .primaryButtonPressed : ShieldConfiguration의 primaryButtonLabel에 해당됩니다.
    ///  - .secondaryButtonPressed: ShieldConfiguration의 secondaryButtonLabel에 해당됩니다.
    /// * case를 구분하지 않거나, 사용하지 않을 경우, 모든 버튼 클릭 시 동작하도록 할 수 있습니다.
    /// * ShieldConfiguration로 설정 된 secondaryButtonLabel이 없을 경우, 해당 case를 사용할 수 없습니다.
    override func handle(
        action: ShieldAction,
        for application: ApplicationToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void) {
            // Handle the action as needed.
            switch action {
            case .primaryButtonPressed:
                /// 시스템이 현재 어플리케이션이나 웹 브라우저를 닫도록 합니다.
                completionHandler(.close)
            case .secondaryButtonPressed:
                /// 액션에 대한 응답을 지연시키며 뷰를 갱신합니다.
               // let dailyStore = ManagedSettingsStore()
                requestSendNoti(seconds: 1, title: "")
                completionHandler(.defer)
            @unknown default:
                fatalError()
            }
        }
    
    // MARK: WebDomainToken으로 설정 된 웹에서 버튼 클릭 시 동작을 설정합니다.
    override func handle(
        action: ShieldAction,
        for webDomain: WebDomainToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void) {
            // Handle the action as needed.
            switch action {
            case .primaryButtonPressed:
                /// 시스템이 현재 어플리케이션이나 웹 브라우저를 닫도록 합니다.
                completionHandler(.close)
            case .secondaryButtonPressed:
                /// 액션에 대한 응답을 지연시키며 뷰를 갱신합니다.
                requestSendNoti(seconds: 1, title: tokenName)
                completionHandler(.defer)
            @unknown default:
                fatalError()
            }
        }
    
    // MARK: ActivityCategoryToken으로 설정 된 웹에서 버튼 클릭 시 동작을 설정합니다.
    /// ActivityCategory는 각 Application이 App Category를 기준으로 분류 시킨 상위 카테고리 그룹입니다.
    /// ActivityCategory 내의 모든 Application 설정 시 ActivityCategory으로 설정하였다고 시스템은 인식합니다.
    override func handle(
        action: ShieldAction,
        for category: ActivityCategoryToken,
        completionHandler: @escaping (ShieldActionResponse) -> Void) {
            // Handle the action as needed.
            switch action {
            case .primaryButtonPressed:
                /// 시스템이 현재 어플리케이션이나 웹 브라우저를 닫도록 합니다.
                completionHandler(.close)
            case .secondaryButtonPressed:
                /// 액션에 대한 응답을 지연시키며 뷰를 갱신합니다.
                requestSendNoti(seconds: 1, title: "")
                completionHandler(.defer)
            @unknown default:
                fatalError()
            }
        }
    func requestSendNoti(seconds: Double, title: String) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "하면함"
        notiContent.body = "이용 시간을 연장해주세요"
        notiContent.userInfo = ["AppName": title] // 푸시 받을때 오는 데이터
        
        // 알림이 trigger되는 시간 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )
        
        userNotiCenter.add(request) { (error) in
            print(#function, error)
        }
        
    }
}

