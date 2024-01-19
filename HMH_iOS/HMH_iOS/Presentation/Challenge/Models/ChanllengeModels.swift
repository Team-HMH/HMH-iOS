//
//  ChanllengeModels.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/3/24.
//

import Foundation

enum ChallengeType {
    case sevenDays
    case fourteenDays
    case completed
}

final class ChallengeManager {
    static let shared = ChallengeManager()
    private init() {
        self.type = .completed
    }
    var type: ChallengeType
    
    func updateType(_ type: ChallengeType) {
        self.type = type
    }
}

