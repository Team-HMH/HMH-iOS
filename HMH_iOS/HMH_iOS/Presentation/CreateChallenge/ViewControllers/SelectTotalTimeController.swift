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
            $0.top.equalTo(navigationBar.snp.bottom).offset(271.adjusted)
            $0.leading.equalTo(pickerView.snp.trailing).inset(-12.adjusted)
        }
        
        pickerView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(137.adjusted)
            $0.width.equalTo(65.adjusted)
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

