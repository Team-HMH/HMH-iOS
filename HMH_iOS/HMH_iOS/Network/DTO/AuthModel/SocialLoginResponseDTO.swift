//
//  SocialLoginResponseDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/14/24.
//

import Foundation

struct SocialLogineResponseDTO: Codable {
    let userId: Int
    let token: Token
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case token = "token"
    }
}

struct Token: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
