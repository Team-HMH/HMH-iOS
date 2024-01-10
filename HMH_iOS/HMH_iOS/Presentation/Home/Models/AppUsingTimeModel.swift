//
//  AppUsingTimeModel.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/10/24.
//

import UIKit

struct AppUsingTimeModel {
    
    let appGoalTime: Int
    let usingAppIcon: UIImage
    let usingAppName: String
    let usedTime: Int
    
    init(appGoalTime: Int, usingAppIcon: UIImage, usingAppName: String, usedTime: Int) {
        self.appGoalTime = appGoalTime
        self.usingAppIcon = usingAppIcon
        self.usingAppName = usingAppName
        self.usedTime = usedTime
    }
}

var appUsingTimeModel: [AppUsingTimeModel] = [
    
    .init(appGoalTime: 7200000,
          usingAppIcon: ImageLiterals.TabBar.icHomeSelected,
          usingAppName: "Instagram",
          usedTime: 3200000),
    
        .init(appGoalTime: 2700000,
              usingAppIcon: ImageLiterals.TabBar.icChallengeSelected,
              usingAppName: "melon",
              usedTime: 1500000),
    
        .init(appGoalTime: 9000000,
              usingAppIcon: ImageLiterals.TabBar.icMyPageSelected,
              usingAppName: "Netflix",
              usedTime: 7900000),
]
