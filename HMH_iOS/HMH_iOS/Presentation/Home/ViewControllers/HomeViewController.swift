//
//  HomeViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 12/23/23.
//

import UIKit

final class HomeViewController: UIViewController {
    private let navigationBar = HMHNavigationBar(leftItem: .logo, isBackButton: false, isTitleLabel: false, isPointImage: false, isBackGroundGray: false, titleText: "")
    private let homeView = HMHHomeView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestPermision()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubviews(navigationBar, homeView)
    }
    
    private func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        homeView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
}
