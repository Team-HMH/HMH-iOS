//
//  APIConstants.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/11/24.
//

import Foundation
import Moya

struct APIConstants{
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let auth = "Authorization"
    static let accessToken = UserManager.shared.getAccessToken
    static let appleAccessToken = UserManager.shared.getAppleToken
    static let OS = "OS"
    static let iOS = "iOS"
}

extension APIConstants{
    static let hasSocialTokenHeader = [contentType: applicationJSON,
                                       auth : appleAccessToken]
    static let hasTokenHeader = [contentType: applicationJSON,
                                          OS: iOS,
                                       auth : accessToken]
}
