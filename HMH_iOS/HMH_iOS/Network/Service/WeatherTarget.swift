//
//  WheatherProvider.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/11/24.
//

import Foundation
import Moya

enum WeatherTarget {
    case getWeather(WeatherRequestDTO)
}

extension WeatherTarget: BaseTargetType {
    var method: Moya.Method {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getWeather: return "weather"
        }
    }
    
    var task: Task {
        switch self {
        case .getWeather(WeatherRequestDTO(q: ""))
            return .requestPlain
        }
    }
}




struct APIManager {
    
    private let provider = MoyaProvider<WeatherTarget>()
    
    let customEndpointClosure = { (target : WeatherTarget) -> Endpoint in
        
        return Endpoint(url: URL(target: target).absoluteString, sampleResponseClosure: {.networkResponse(400, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        
    }
    let weatherRequest = WeatherRequestDTO(q: "Seoul")
    private var testingProvider : MoyaProvider<WeatherTarget>?
    
    init(){
        
        testingProvider = .init(endpointClosure: customEndpointClosure,stubClosure: MoyaProvider.immediatelyStub)
        
    }
    
    func weather(request: WeatherRequestDTO, completion : @escaping ([WeatherDTO]) -> () , failure : @escaping (String) -> ()){
        
        provider.request(.getWeather(request), completion: { result in
            switch result {
            case let .success(response) :
                do {
                    let weathermodel = try JSONDecoder().decode([WeatherDTO].self, from: response.data)
                    
                    completion(weathermodel)
                }
                catch let error{
                    failure(error.localizedDescription)
                }
                
            case let .failure(error):
                failure(error.localizedDescription)
            }
            
        })
    }
    
}
