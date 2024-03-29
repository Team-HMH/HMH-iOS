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
    private let surveyView = SurveyView(firstButtonType: .multiple, 
                                        secondButtonType: .multiple,
                                        thirdButtonType: .multiple,
                                        fourthButtonType: .multiple)
    private var textArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        configureSurveyView()
        setProblemSurvey()
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
    
    private func setDelegate() {
        self.delegate = self
    }
    
    private func setProblemSurvey() {
        view.backgroundColor = .background
        step = 2
    }
    
    private func configureSurveyView() {
        nextButtonText = StringLiteral.OnboardingButton.next
        nextButton.setButtonText(buttonTitle: nextButtonText)
        mainTitleText = StringLiteral.OnboardigMain.problemSurvey
        subTitleText = StringLiteral.OnboardigSub.problemSurvey
        surveyView.firstButton.setButtonText(buttonTitle: StringLiteral.ProblemSurveySelect.firstSelect)
        surveyView.secondButton.setButtonText(buttonTitle: StringLiteral.ProblemSurveySelect.secondSelect)
        surveyView.thirdButton.setButtonText(buttonTitle: StringLiteral.ProblemSurveySelect.thirdSelect)
        surveyView.fourthButton.setButtonText(buttonTitle: StringLiteral.ProblemSurveySelect.fourthSelect)
        
        surveyView.firstButton.delegate = self
        surveyView.secondButton.delegate = self
        surveyView.thirdButton.delegate = self
        surveyView.fourthButton.delegate = self
    }
}

extension ProblemSurveyViewController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = SelectPeriodController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        SignUpManager.shared.problem = textArray
    }
}

extension ProblemSurveyViewController: HMHSelectButtonDelegate {
    func updateAvailability(isEnabled: Bool, text: String) {
        nextButton.updateStatus(isEnabled: isEnabled)
        if textArray.contains(text) {
            textArray.removeAll(where: { $0 == text })
        } else {
            textArray.append(text)
        }
    }
}
