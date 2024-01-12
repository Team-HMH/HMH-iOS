//
//  BaseTargetType.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/11/24.
//

import Foundation
import Moya

protocol BaseTargetType: TargetType {}

typealias Parameters = [String: String]

extension BaseTargetType {
    
    var baseURL: URL {
        guard let baseURL = URL(string: Config.baseURL) else {
            print("🚨🚨BASEURL ERROR🚨🚨")
            fatalError()
        }
        return baseURL
    }
    
    var headers: Parameters? {
        return APIConstants.hasTokenHeader
    }
    
    var sampleData: Data {
        return Data()
    }
}
