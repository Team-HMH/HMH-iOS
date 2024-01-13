//
//  GoalTimeSelectView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/9/24.
//

import UIKit

import SnapKit
import Then
import FamilyControls

class GoalTimeSelectView: UIView {
    
    var screenTime = ScreenTime.shared
    private let timePicker = HMHTimePickerView(type: .specificTime)
    private let timeLable = UILabel().then {
        $0.text = StringLiteral.Challenge.Time.timeLabel
        $0.font = .iosText2Medium20
        $0.textColor = .gray2
    }
    private let minPicker = HMHTimePickerView(type: .specificMinute)
    private let minLable = UILabel().then {
        $0.text = StringLiteral.Challenge.Time.minLabel
        $0.font = .iosText2Medium20
        $0.textColor = .gray2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubviews(timePicker,timeLable,minPicker,minLable)
    }
    
    private func setConstraints() {
        timePicker.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(72.adjusted)
            $0.width.equalTo(67.adjusted)
        }
        
        timeLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(timePicker.snp.trailing).offset(-7.adjusted)
        }
        
        minPicker.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(timeLable.snp.trailing).offset(23.adjusted)
            $0.width.equalTo(67.adjusted)
        }
        
        minLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(minPicker.snp.trailing).offset(2.adjusted)
        }
    }
    
    private func configureView() {
        self.backgroundColor = .background
    }
}
