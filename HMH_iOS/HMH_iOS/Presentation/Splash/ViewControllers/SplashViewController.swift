//
//  SplashViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/9/24.
//

import UIKit
import Moya

final class SplashViewController: UIViewController {
    
    let apiManager = APIManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        let request = WeatherRequestDTO(q: "Seoul")
        apiManager.weather(request: request) { data in
            print(data)
        } failure: { error in
            print(error)
        }

    }
}

