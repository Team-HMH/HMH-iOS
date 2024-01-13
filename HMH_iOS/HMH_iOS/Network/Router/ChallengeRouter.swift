//
//  ChallengeRouter.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/12/24.
//

import Foundation

import Moya

enum ChallengeRouter {
    case createChallenge(data: CreateChallengeRequestDTO)
}

extension ChallengeRouter: BaseTargetType {
    var headers: [String : String]? {
        switch self {
        case .createChallenge:
            return APIConstants.hasTokenHeader
        }
    }
    
    var path: String {
        switch self {
        case .createChallenge:
            return "challenge"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createChallenge:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createChallenge(let data):
            return .requestJSONEncodable(data)
        }
    }
}
