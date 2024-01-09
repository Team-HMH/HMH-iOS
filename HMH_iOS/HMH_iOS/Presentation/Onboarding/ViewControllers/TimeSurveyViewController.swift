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
    private let surveyView = SurveyView(buttonType: .solitary)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        nextButtonText = StringLiteral.OnboardingButton.next
        nextButton.setButtonText(buttonTitle: nextButtonText)
        mainTitleText = StringLiteral.OnboardigMain.TimeSurvey

        self.delegate = self
        step = 1
        setUI()
        configureSurveyView()
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
    
    private func configureSurveyView() {
        surveyView.firstButton.setButtonText(buttonTitle: StringLiteral.TimeSurveySelect.firstSelect)
        surveyView.secondButton.setButtonText(buttonTitle: StringLiteral.TimeSurveySelect.secondSelect)
        surveyView.thirdButton.setButtonText(buttonTitle: StringLiteral.TimeSurveySelect.thirdSelect)
        surveyView.fourthButton.setButtonText(buttonTitle: StringLiteral.TimeSurveySelect.fourthSelect)
    }
}

extension TimeSurveyViewController: HomeViewPushDelegate {
    func didTapButton() {
        let placeViewController = ProblemSurveyViewController()
        self.navigationController?.pushViewController(placeViewController, animated: false)
    }
}
