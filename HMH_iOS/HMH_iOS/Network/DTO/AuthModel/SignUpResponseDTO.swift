//
//  SignUpResponseDTO.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/14/24.
//

import Foundation

struct SignUpResponseDTO: Codable {
    let userId: Int
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
}
