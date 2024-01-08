//
//  OnboardingBaseViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/8/24.
//

import UIKit

import SnapKit
import Then

protocol HomeViewPushDelegate: AnyObject {
    func didTapButton()
}

class OnboardingBaseViewController: UIViewController {
    weak var delegate: HomeViewPushDelegate?
    
    let navigationBar = HMHNavigationBar(leftItem: .normal, isBackButton: true, isTitleLabel: false, isPointImage: false)
    let progressBar = ProgressBarManager.shared.progressBarView
    let nextButton = OnboardingButton(buttonStatus: .enabled, buttonText: "완료")
    var step = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        setUI()
        setTarget()
        ProgressBarManager.shared.updateProgress(for: self, step: step)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTarget()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        view.addSubviews(navigationBar, nextButton, progressBar)
    }

    func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(113)
        }
        
        progressBar.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-21)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setTarget() {
        nextButton.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
    }
    
    @objc
        func onTapButton() {
            print("taptaptap")
            self.delegate?.didTapButton()
    }
}





