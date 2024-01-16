//
//  TotalAppUsingTimeDataModel.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/10/24.
//

import Foundation

struct TotalAppUsingTimeDataModel {
    var onboardingTotalGoalTime: Float
    var totalAppRemainedTime: Float
    var isFailed: Bool
    
    static func calculateTotalUsageTime(data: [AppUsingTimeModel]) -> Int {
        return data.reduce(0) { $0 + Int($1.usedTime) }
    }
}
