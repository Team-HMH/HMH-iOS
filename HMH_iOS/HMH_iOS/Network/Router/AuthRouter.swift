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
    case signUp(data: SignUpRequestDTO)
}

extension AuthRouter: BaseTargetType {
    var headers: [String : String]? {
        switch self {
        case .socialLogin:
            return APIConstants.hasSocialTokenHeader
        case .signUp:
            return APIConstants.hasTokenHeader
        }
    }
    
    
    var path: String {
        switch self {
        case .socialLogin:
            return "user/login"
        case .signUp:
            return "user/signup"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .socialLogin:
            return .post
        case .signUp:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .socialLogin(let data):
            return .requestJSONEncodable(data)
        case .signUp(let data):
            return .requestJSONEncodable(data)
        }
    }
}
