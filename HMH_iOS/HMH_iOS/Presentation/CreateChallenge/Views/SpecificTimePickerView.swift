//
//  SpecificTimePickerView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/4/24.
//

import UIKit

import SnapKit
import Then

final class SpecificTimePickerView: UIPickerView {
    private let hours: [String] = ["0", "1"]
    private let minutes: [String] = Array(0...59).map { String($0) }
    
    private let hourLabel = UILabel().then {
        $0.textColor = .gray2
        $0.font = .iosText2Medium20
        $0.text = "시간"
    }
    
    private let minuteLabel = UILabel().then {
        $0.textColor = .gray2
        $0.font = .iosText2Medium20
        $0.text = "분"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        configurePickerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubviews(hourLabel, minuteLabel)
    }
    
    private func setConstraints() {
        hourLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(122.adjusted)
        }
        
        minuteLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(38.adjusted)
        }
    }
    
    private func configurePickerView() {
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
    }
}

extension SpecificTimePickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hours.count
        } else {
            return minutes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return hours[row]
        } else {
            return minutes[row]
        }
    }
    
    var selectedRow: Int {
        return self.selectedRow(inComponent: 0)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.reloadComponent(component)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var color = UIColor.gray3
        var font = UIFont.iosText1Medium22
        
        if component == 0 && row == pickerView.selectedRow(inComponent: 0) {
            color = UIColor.whiteText
            font = UIFont.iosText1Medium22
        }
        
        if component == 1 && row == pickerView.selectedRow(inComponent: 1) {
            color = UIColor.whiteText
            font = UIFont.iosText1Medium22
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font
        ]
        
        if component == 0 {
            return NSAttributedString(string: hours[row], attributes: attributes)
        } else {
            return NSAttributedString(string: minutes[row], attributes: attributes)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 53.adjusted
    }
}

