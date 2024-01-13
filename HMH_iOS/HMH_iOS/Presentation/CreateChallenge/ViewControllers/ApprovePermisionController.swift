//
//  ApprovePermisionController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class ApprovePermisionController: OnboardingBaseViewController {
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
        nextButton.updateStatus(isEnabled: true)
    }
    
    private func configureSurveyView() {
        nextButtonText = StringLiteral.OnboardingButton.permission
        nextButton.setButtonText(buttonTitle: nextButtonText)
        mainTitleText = StringLiteral.OnboardigMain.approvePermision
        subTitleText = StringLiteral.OnboardigSub.approvePermision
    }
}

extension ApprovePermisionController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = AppSelectViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
}

