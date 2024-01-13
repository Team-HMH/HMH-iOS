//
//  MyPageRouter.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/14/24.
//

import Foundation

import Moya

enum MyPageRouter {
    case getUserData(data: GetUserDataResponseDTO)
}

extension MyPageRouter: BaseTargetType {
    private var headers: Parameters {
        switch self {
        case .getUserData:
            return APIConstants.hasTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .getUserData:
            return "user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getUserData(let data):
            return .requestPlain
        }
    }
}

