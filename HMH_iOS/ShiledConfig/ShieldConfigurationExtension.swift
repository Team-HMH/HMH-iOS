//
//  ShieldConfigurationExtension.swift
//  ShieldConfiguration
//
//  Created by Yun Dongbeom on 2023/08/08.
//

// 여기에서 토큰과 Displayed Name 딕셔너리 타입으로 UserDefault 저장!!
// HMH-iOS에서는 이에 대한 처리만. 서버에 토큰 보내고 받은 토큰으로 이름 보여주기 필요.

import ManagedSettings
import ManagedSettingsUI
import UIKit
import SwiftUI
// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
// MARK: - ShieldView 커스터마이징
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    // MARK: - 제한 중인 앱/도메인 웹 정보를 받아 ShieldView를 커스터마이징하는 메서드
    /// 앱/도메인 웹 사용 제한 중일 경우 overlay되는 ShieldView는 ShieldConfiguration를 통해 커스터마이징 할 수 있습니다.
    /// 각 configuration 메서드로부터 전달받은 앱 정보를 통해 커스터마이징 해보세요.
    ///  * ShieldConfiguration init 이외에 ShieldView의 커스터마이징은 제한됩니다.
    ///  * 더 많은 정보는 아래 링크를 확인하세요.
    ///  https://developer.apple.com/documentation/managedsettingsui/shieldconfiguration
    @AppStorage("tokenName", store: UserDefaults(suiteName: "group.65NSM7Z327.com.HMH.group")) var tokenName = ""
    
    private func setShieldConfig(
        _ tokenName: String,
        hasSecondaryButton: Bool = false) -> ShieldConfiguration {
            let CUSTOM_ICON = UIImage(named: "ios_limit_time_img")
            let CUSTOM_TITLE = ShieldConfiguration.Label(
                text: "목표 사용 시간 종료",
                color: .white
            )
            let CUSTOM_SUBTITLE = ShieldConfiguration.Label(
                text: "이제 \(tokenName)을(를) 사용할 수 없어요\n\n※ 알림이 오지 않는다면 설정에서 푸시 알림 권한을 허용해 주세요",
                color: UIColor(red: 0.55, green: 0.55, blue: 0.62, alpha: 1)
            )
            let CUSTOM_PRIMARY_BUTTON_LABEL = ShieldConfiguration.Label(
                text: "닫기",
                color: UIColor(red: 0.86, green: 0.86, blue: 0.91, alpha: 1)
            )
            let CUSTOM_PRIAMRY_BUTTON_BACKGROUND: UIColor = UIColor(red: 0.24, green: 0.09, blue: 0.83, alpha: 1)
            let CUSTOM_SECONDARY_BUTTON_LABEL = ShieldConfiguration.Label(
                text: "잠금 해제하기",
                color: UIColor(red: 0.65, green: 0.65, blue: 0.73, alpha: 1)
            )
            
            let backgrounColor = UIColor(hue: 240/360, saturation: 14/100, brightness: 10/100, alpha: 1.0)
            
            let ONE_BUTTON_SHIELD_CONFIG = ShieldConfiguration(
                backgroundBlurStyle: .systemMaterial,
                backgroundColor: backgrounColor,
                icon: CUSTOM_ICON,
                title: CUSTOM_TITLE,
                subtitle: CUSTOM_SUBTITLE,
                primaryButtonLabel: CUSTOM_PRIMARY_BUTTON_LABEL,
                primaryButtonBackgroundColor: CUSTOM_PRIAMRY_BUTTON_BACKGROUND
            )
            
            let TWO_BUTTON_SHIELD_CONFIG = ShieldConfiguration(
                backgroundBlurStyle: .dark,
                backgroundColor: backgrounColor,
                icon: CUSTOM_ICON,
                title: CUSTOM_TITLE,
                subtitle: CUSTOM_SUBTITLE,
                primaryButtonLabel: CUSTOM_PRIMARY_BUTTON_LABEL,
                primaryButtonBackgroundColor: CUSTOM_PRIAMRY_BUTTON_BACKGROUND,
                secondaryButtonLabel: CUSTOM_SECONDARY_BUTTON_LABEL
            )
            
            return hasSecondaryButton ? TWO_BUTTON_SHIELD_CONFIG : ONE_BUTTON_SHIELD_CONFIG
        }
    
    // MARK: - 어플리케이션만 제한된 앱
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        guard let displayName = application.localizedDisplayName else {
            return setShieldConfig("확인불가 앱")
        }
        
        return setShieldConfig(displayName, hasSecondaryButton: true)
    }
    
    // MARK: - 카테고리를 통해 어플리케이션이 제한된 앱
    override func configuration(
        shielding application: Application,
        in category: ActivityCategory) -> ShieldConfiguration {
            // Customize the shield as needed for applications shielded because of their category.
            guard let displayName = application.localizedDisplayName,
                  let categoryName = category.localizedDisplayName else {
                return setShieldConfig("확인불가 앱")
            }
            tokenName = displayName
            return setShieldConfig(categoryName + " " + displayName, hasSecondaryButton: true)
        }
    
    // MARK: - 웹 도메인만 제한된 앱
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        guard let displayName = webDomain.domain else {
            return setShieldConfig("확인불가 웹 도메인")
        }
        tokenName = displayName
        return setShieldConfig(displayName)
    }
    
    // MARK: - 카테고리를 통해 웹 도메인이 제한된 앱
    override func configuration(
        shielding webDomain: WebDomain,
        in category: ActivityCategory) -> ShieldConfiguration {
            // Customize the shield as needed for web domains shielded because of their category.
            guard let displayName = webDomain.domain,
                  let categoryName = category.localizedDisplayName else {
                return setShieldConfig("확인불가 웹 도메인")
            }
            tokenName = displayName
            return setShieldConfig(categoryName + " " + displayName)
        }
}
