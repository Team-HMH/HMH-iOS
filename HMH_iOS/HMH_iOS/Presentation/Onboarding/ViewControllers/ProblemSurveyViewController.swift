//
//  ProblemSurveyViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class ProblemSurveyViewController: OnboardingBaseViewController {
    
    private let surveyView = SurveyView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        view.addSubviews(surveyView)
        nextButtonText = "하이gpffhfhfhhf"
        nextButton.setButtonText(buttonTitle: nextButtonText)
        step = 2
        
        surveyView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(94.adjustedHeight)
            $0.leading.trailing.equalTo(progressBar)
            $0.height.equalTo(275.adjusted)
        }
    }


}

