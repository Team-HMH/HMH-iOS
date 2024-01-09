//
//  SelectTotalTimeController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class SelectTotalTimeController: OnboardingBaseViewController {
    private let surveyView = SurveyView(buttonType: .solitary)
    
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
        step = 4
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
    }
}

extension SelectTotalTimeController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = ApprovePermisionController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
}
