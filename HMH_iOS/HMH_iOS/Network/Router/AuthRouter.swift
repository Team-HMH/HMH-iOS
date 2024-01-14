//
//  AuthRouter.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/14/24.
//

import Foundation

import Moya

enum AuthRouter {
    case socialLogin(data: SocialLoginRequestDTO)
}

extension AuthRouter: BaseTargetType {
    var headers: [String : String]? {
        switch self {
        case .socialLogin:
            return APIConstants.hasSocialTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .socialLogin:
            return "user/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .socialLogin:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .socialLogin(let data):
            return .requestJSONEncodable(data)
        }
    }
}
