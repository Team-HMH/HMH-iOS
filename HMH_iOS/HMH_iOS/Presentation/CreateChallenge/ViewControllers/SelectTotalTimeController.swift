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
    private let pickerView = TotalTimePickerView()
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
        view.addSubview(pickerView)
    }
    
    private func setConstraints() {
        pickerView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(94.adjustedHeight)
            $0.leading.trailing.equalTo(progressBar)
        }
    }
    
    private func setDelegate() {
        self.delegate = self
        pickerView.totalTimePickerDelegate = self
    }
    
    private func setTimeSurvey() {
        view.backgroundColor = .background
        step = 4
    }
    
    private func configureSurveyView() {
        nextButtonText = StringLiteral.OnboardingButton.next
        nextButton.setButtonText(buttonTitle: nextButtonText)
        mainTitleText = StringLiteral.OnboardigMain.selectTotalTime
        subTitleText = StringLiteral.OnboardigSub.selectTotalTime
    }
}

extension SelectTotalTimeController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = ApprovePermisionController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
}

extension SelectTotalTimeController: TotalTimePickerDelegate {
    func updateAvailability() {
        nextButton.updateStatus(isEnabled: true)
    }
}
