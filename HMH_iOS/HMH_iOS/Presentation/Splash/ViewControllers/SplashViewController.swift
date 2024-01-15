//
//  SplashViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/9/24.
//

import UIKit
import Moya

final class SplashViewController: UIViewController {
    
    private let splashImage = UIImageView().then {
        $0.image = ImageLiterals.Splash.splash
        $0.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setSplashView()
    }
    
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(splashImage)
    }
    
    private func setConstraints() {
        splashImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(266.adjusted)
        }
    }
    
    private func setSplashView() {
        view.backgroundColor = .background
        let provider = Providers.AuthProvider
        provider.request(target: .tokenRefresh, instance: BaseResponse<RefreshTokebResponseDTO>.self, viewController: LoginViewController()) { data in
            if let data = data.data {
                UserManager.shared.updateToken(data.token.accessToken, data.token.accessToken)
                print("token",data.token.accessToken,data.token.accessToken)
            }
        }
    }
}

