//
//  UserModel.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/9/24.
//

import Foundation

struct UserModel {
    let userName: String
    let point: Int
}

extension UserModel {
    static func dummy() -> UserModel {
        return UserModel(userName: "여민서", point: 3000)
    }
}
