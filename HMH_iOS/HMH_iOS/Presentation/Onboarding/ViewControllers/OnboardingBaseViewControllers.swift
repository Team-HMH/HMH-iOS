//
//  OnboardingBaseViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/8/24.
//

import UIKit

import SnapKit
import Then

protocol NextViewPushDelegate: AnyObject {
    func didTapButton()
}

class OnboardingBaseViewController: UIViewController {
    weak var delegate: NextViewPushDelegate?
    
    let mainTitleLabel = UILabel().then {
        $0.textColor = .whiteText
        $0.font = .iosTitle1Semibold22
        $0.text = StringLiteral.OnboardingButton.next
        $0.numberOfLines = 2
    }
    private let subTitleLabel = UILabel().then {
        $0.textColor = .gray2
        $0.font = .iosText6Medium14
        $0.text = StringLiteral.OnboardingButton.next
    }
    var nextButtonText: String = StringLiteral.OnboardingButton.next
    var mainTitleText: String = ""
    var subTitleText: String = ""
    let navigationBar = HMHNavigationBar(leftItem: .normal, 
                                         isBackButton: true,
                                         isTitleLabel: false,
                                         isPointImage: false,
                                         isBackGroundGray: false)
    let progressBar = ProgressBarManager.shared.progressBarView
    lazy var nextButton = OnboardingButton(buttonStatus: .enabled)
    var step = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        setUI()
        setTarget()
        ProgressBarManager.shared.updateProgress(step: step)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTarget()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
        mainTitleLabel.text = mainTitleText
        subTitleLabel.text = subTitleText
    }
    
    private func setHierarchy() {
        view.addSubviews(navigationBar, nextButton, progressBar, mainTitleLabel, subTitleLabel)
    }
    
    private func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.trailing.leading.equalToSuperview().inset(20.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-21.adjusted)
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
        }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(34.adjusted)
            $0.leading.equalTo(progressBar)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(4.adjusted)
            $0.leading.equalTo(progressBar)
            
        }
    }
    
    private func setTarget() {
        nextButton.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
    }
    
    @objc
    func onTapButton() {
        self.delegate?.didTapButton()
    }
}





