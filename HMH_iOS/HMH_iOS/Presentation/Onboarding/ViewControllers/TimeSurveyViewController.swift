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
    private let surveyView = SurveyView(firstButtonType: .solitary, secondButtonType: .solitary, thirdButtonType: .solitary, fourthButtonType: .solitary)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configureSurveyView()
        setDelegate()
        setTimeSurvey()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUI()
    }
    
    private func setUI(){
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        view.addSubview(surveyView)
    }
    
    private func setConstraints() {
        surveyView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(94.adjustedHeight)
            $0.leading.trailing.equalTo(progressBar)
        }
    }
    
    private func setDelegate() {
        self.delegate = self
    }
    
    private func setTimeSurvey() {
        view.backgroundColor = .background
        step = 1
    }
    
    private func configureSurveyView() {
        nextButtonText = StringLiteral.OnboardingButton.next
        nextButton.setButtonText(buttonTitle: nextButtonText)
        mainTitleText = StringLiteral.OnboardigMain.timeSurvey
        surveyView.firstButton.setButtonText(buttonTitle: StringLiteral.TimeSurveySelect.firstSelect)
        surveyView.secondButton.setButtonText(buttonTitle: StringLiteral.TimeSurveySelect.secondSelect)
        surveyView.thirdButton.setButtonText(buttonTitle: StringLiteral.TimeSurveySelect.thirdSelect)
        surveyView.fourthButton.setButtonText(buttonTitle: StringLiteral.TimeSurveySelect.fourthSelect)
        
        surveyView.firstButton.delegate = self
        surveyView.secondButton.delegate = self
        surveyView.thirdButton.delegate = self
        surveyView.fourthButton.delegate = self
    }
}

extension TimeSurveyViewController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = ProblemSurveyViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
}

extension TimeSurveyViewController: HMHSelectButtonDelegate {
    func updateAvailability(isEnabled: Bool) {
        print("taptap")
        updateNextButtonStatus(buttonStatus: isEnabled)
    }
}
