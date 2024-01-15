//
//  AppSelectViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class AppSelectViewController: OnboardingBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSurveyView()
        setDelegate()
        setTimeSurvey()
    }
    
    private func setDelegate() {
        self.delegate = self
    }
    
    private func setTimeSurvey() {
        view.backgroundColor = .background
        step = 5
    }
    
    private func configureSurveyView() {
        nextButtonText = StringLiteral.OnboardingButton.permission
        nextButton.setButtonText(buttonTitle: nextButtonText)
        mainTitleText = StringLiteral.OnboardigMain.appSelect
        subTitleText = StringLiteral.OnboardigSub.appSelect
    }
}

extension AppSelectViewController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = AppSelectViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
}


