//
//  SignUpManager.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/9/24.
//

import UIKit

class SignUpManager {
    static let shared = SignUpManager()
    
    var averageUseTime: String = "1"
    var problem: [String] = ["12"]
    var period: Int = 3
    var goalTime: Int = 3
    var appCode: [Apps] = [Apps(appCode: "#25393", goalTime: 76000),
                           Apps(appCode: "#25391", goalTime: 89000)]
}

