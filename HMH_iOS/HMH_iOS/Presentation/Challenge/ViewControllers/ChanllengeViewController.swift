//
//  ChanllengeViewController.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/3/24.
//

import UIKit

final class ChanllengeViewController: UIViewController {
    
    
    private let navigationBar = HMHNavigationBar(leftItem: .normal,
                                                 isBackButton: false,
                                                 isTitleLabel: true,
                                                 isPointImage: true,
                                                 titleText: StringLiteral.Challenge.NavigationBarTitle)
    private let challengeView = ChallengeView()
    
    override func loadView() {
        self.view = challengeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDelegate()
    }
    
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(navigationBar)
    }
    
    private func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(63.adjustedHeight)
        }
    }
    
    private func setDelegate(){
        challengeView.challengeCollectionView.delegate = self
    }
}

extension ChanllengeViewController: UICollectionViewDelegate {}

extension ChanllengeViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationBar.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationBar.alpha = 1
            })
        }
    }
    
        
}
