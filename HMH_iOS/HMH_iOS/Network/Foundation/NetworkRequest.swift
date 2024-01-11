//
//  NetworkRequest.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/11/24.
//

import Foundation
import Moya

struct NetworkRequest {
    let url: String
    let httpMethod: Moya.Method
    let body: Data?                // optional
    let headers: [String: String]? // optional
    
    init(url: String,
         httpMethod: Moya.Method,
         requestBody: Data? = nil,
         headers: [String: String]? = nil
    ) {
        self.url = url
        self.httpMethod = httpMethod
        self.body = requestBody
        self.headers = headers
    }
    
    func createURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        return urlRequest
    }
}

