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
        loadChallenge()
    }
    var type: ChallengeType
    
    func updateType(_ type: ChallengeType) {
        self.type = type
    }
    
    func loadChallenge() {
        let provider = Providers.challengeProvider
        provider.request(target: .getChallenge, instance: BaseResponse<GetChallengeResponseDTO>.self) { result in
            if let data = result.data {
               if data.todayIndex == -1 {
                    self.type = .completed
               } else if data.period == 7 {
                   self.type = .sevenDays
               } else if data.period == 14 {
                   self.type = .fourteenDays
               }
            }
        }
    }
}

