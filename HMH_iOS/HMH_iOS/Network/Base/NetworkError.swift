//
//  NetworkError.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/11/24.
//

import Foundation

enum NetworkError: Error {
    case httpError(ErrorResponse)
    case decodedError
    case networkFail
    case error(Error?)
}
