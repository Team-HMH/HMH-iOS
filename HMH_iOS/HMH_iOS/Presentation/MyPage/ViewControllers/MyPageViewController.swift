//
//  MyPageViewController.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/3/24.
//

import UIKit

final class MyPageViewController: UIViewController {
    private let navigationBar = HMHNavigationBar(leftItem: .normal, isBackButton: false, isTitleLabel: true, isPointImage: false, isBackGroundGray: false, titleText: "마이페이지")
    private let myPageView = MyPageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configureView()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
        
    }
    
    private func setHierarchy() {
        view.addSubviews(navigationBar, myPageView)
    }
    
    private func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        myPageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    private func configureView() {
        view.backgroundColor = .gray8
    }
}
