//
//  GetDummyResponseDTO.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/19/24.
//

import Foundation

struct GetDummyResponseDTO: Codable {
    let apps: [App]
}

struct App: Codable {
    let appName: String
    let appImageURL: String
    let goalTime, usageTime: Int
    
    enum CodingKeys: String, CodingKey {
        case appName
        case appImageURL = "appImageUrl"
        case goalTime, usageTime
    }
}
//
//var getDummyResponseDTO: [GetDummyResponseDTO] = [
//    .init(apps: [App(appName: "Netflix",
//                     appImageURL: "https://github.com/Team-HMH/HMH-Server/assets/69035864/dd068b83-641a-4bff-b4f5-381ea6e04d44",
//                     goalTime: 2400000,
//                     usageTime: 1320000)]),
//    
//    .init(apps: [App(appName: "Instagram",
//                     appImageURL: "https://github.com/Team-HMH/HMH-Server/assets/69035864/bd572377-9dd9-47e7-a9f4-9efbbe66cd2e",
//                     goalTime: 5400000,
//                     usageTime: 2880000)]),
//    
//    .init(apps: [App(appName: "YouTube",
//                     appImageURL: "https://github.com/Team-HMH/HMH-Server/assets/69035864/8afa60c0-bf1d-4ff0-9b50-4d1558a71f0a",
//                     goalTime: 3300000,
//                     usageTime: 900000)]),
//]
