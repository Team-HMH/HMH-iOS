//
//  MyPageViewController.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/3/24.
//

import UIKit

final class MyPageViewController: UIViewController {
    private let navigationBar = HMHNavigationBar(leftItem: .normal, isBackButton: false, isTitleLabel: true, isPointImage: false, isBackGroundGray: true, titleText: "마이페이지")
    private let myPageView = MyPageView()
    
    override func loadView() {
        self.view = myPageView
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
        view.addSubviews(navigationBar)
    }
    
    private func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
}
