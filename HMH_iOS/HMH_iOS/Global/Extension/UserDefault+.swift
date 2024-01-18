//
//  UserDefault+.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/14/24.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.65NSM72327.HMH-iOS.HMH-iOS"
        return UserDefaults(suiteName: appGroupId)!
    }
}
