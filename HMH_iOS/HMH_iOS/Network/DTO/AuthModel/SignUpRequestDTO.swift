//
//  SignUpRequestDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/14/24.
//

import Foundation

struct SignUpRequestDTO: Codable {
    let socialPlatform: String
    let onboarding: Onboarding
    let challenge: Challenge
    
    enum CodingKeys: String, CodingKey {
        case socialPlatform = "userId"
        case onboarding
        case challenge
    }
}

struct Onboarding: Codable {
    let averageUseTime: String
    let problem: [String]
    
    enum CodingKeys: String, CodingKey {
        case averageUseTime = "averageUseTime"
        case problem
    }
}

struct Challenge: Codable {
    let period: Int
    let goalTime: Int
    let apps: [Apps]
    
    enum CodingKeys: String, CodingKey {
        case period
        case goalTime
        case apps
    }
}

struct Apps: Codable {
    let appCode: String
    let goalTime: Int
    
    enum CodingKeys: String, CodingKey {
        case appCode
        case goalTime
    }
}
