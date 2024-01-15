//
//  SelectTotalTimeController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingTotalTimeController: OnboardingBaseViewController {
    private var totalTime = 0
    private let pickerView = HMHTimePickerView(type: .totalTime)
    private let titleLabel = UILabel().then {
        $0.textColor = .gray2
        $0.font = .iosText2Medium20
        $0.text = "시간"
    }
    
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
        view.addSubviews(pickerView,titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(281.adjusted)
            $0.leading.equalTo(pickerView.snp.trailing).inset(-2.adjusted)
        }
        
        pickerView.snp.makeConstraints {
            $0.leading.equalTo(progressBar.snp.leading).inset(106.adjusted)
            $0.width.equalTo(67.adjusted)
            $0.centerY.equalTo(titleLabel.snp.centerY)
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

extension OnboardingTotalTimeController: NextViewPushDelegate {
    func didTapButton() {
        let nextViewController = ApprovePermisionController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        SignUpManager.shared.goalTime = totalTime
    }
}

extension OnboardingTotalTimeController: TimePickerDelegate {
    func updateAvailability(selectedValue: Int) {
        nextButton.updateStatus(isEnabled: true)
        totalTime = selectedValue
    }
}
