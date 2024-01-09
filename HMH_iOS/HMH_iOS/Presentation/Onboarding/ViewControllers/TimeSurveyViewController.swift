//
//  TimeSurveyViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class TimeSurveyViewController: OnboardingBaseViewController {
    private let surveyView = SurveyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        nextButtonText = StringLiteral.OnboardingButton.next
        nextButton.setButtonText(buttonTitle: nextButtonText)
        surveyView.firstButton.setButtonText(buttonTitle: StringLiteral.AlertButton.cancel)
        surveyView.secondButton.setButtonText(buttonTitle: StringLiteral.AlertButton.cancel)
        surveyView.thirdButton.setButtonText(buttonTitle: StringLiteral.AlertButton.cancel)
        surveyView.fourthButton.setButtonText(buttonTitle: StringLiteral.AlertButton.cancel)
        self.delegate = self
        step = 1
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUI()
    }
    
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubview(surveyView)
    }
    
    private func setConstraints() {
        surveyView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(94.adjustedHeight)
            $0.leading.trailing.equalTo(progressBar)
        }
    }
}

extension TimeSurveyViewController: HomeViewPushDelegate {
    func didTapButton() {
        let placeViewController = ProblemSurveyViewController()
        self.navigationController?.pushViewController(placeViewController, animated: false)
    }
}
