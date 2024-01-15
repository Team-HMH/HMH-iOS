//
//  AppDelegate.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 12/23/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let userNotiCenter = UNUserNotificationCenter.current()
        userNotiCenter.delegate = self
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // deep link처리 시 아래 url값 가지고 처리
        guard let appName = response.notification.request.content.userInfo.values.first as? String else { return }
        showCustomAlert(appName: String(stringLiteral: appName))
        completionHandler()
    }
    
    func showCustomAlert(appName: String) {
        let pushAertViewController = AlertViewController()
        pushAertViewController.appName = appName
        pushAertViewController.alertType = .HMHPushALert
        pushAertViewController.modalPresentationStyle = .overFullScreen
        UIApplication.shared.windows.first?.rootViewController?.present(pushAertViewController, animated: false, completion: nil)
    }
}
