//
//  SelectPeriodController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class SelectPeriodController: OnboardingBaseViewController {
    private let surveyView = SurveyView(firstButtonType: .solitary, secondButtonType: .solitary, thirdButtonType: .disabled, fourthButtonType: .disabled)
    private var selectPeriod = ""
    
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
        step = 3
    }
    
    private func configureSurveyView() {
        nextButtonText = StringLiteral.OnboardingButton.next
        nextButton.setButtonText(buttonTitle: nextButtonText)
        mainTitleText = StringLiteral.OnboardigMain.selectPeriod
        subTitleText = StringLiteral.OnboardigSub.selectPeriod
        surveyView.firstButton.setButtonText(buttonTitle: StringLiteral.PeriodSelect.firstSelect)
        surveyView.secondButton.setButtonText(buttonTitle: StringLiteral.PeriodSelect.secondSelect)
        surveyView.thirdButton.setButtonText(buttonTitle: StringLiteral.PeriodSelect.thirdSelect)
        surveyView.fourthButton.setButtonText(buttonTitle: StringLiteral.PeriodSelect.fourthSelect)
        
        surveyView.firstButton.delegate = self
        surveyView.secondButton.delegate = self
        surveyView.thirdButton.delegate = self
        surveyView.fourthButton.delegate = self
    }
    
    func convertAndRemoveLastCharacter(_ input: String) -> Int? {
        guard let intValue = Int(String(input.dropLast())) else {
            return nil
        }
        return intValue
    }
}

extension SelectPeriodController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = SelectTotalTimeController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        SignUpManager.shared.period = convertAndRemoveLastCharacter(selectPeriod) ?? 0
        print(SignUpManager.shared.problem)
    }
}

extension SelectPeriodController: HMHSelectButtonDelegate {
    func updateAvailability(isEnabled: Bool, text: String) {
        nextButton.updateStatus(isEnabled: isEnabled)
        selectPeriod = text
    }
}
