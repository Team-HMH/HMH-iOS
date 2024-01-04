//
//  TotalTimePickerView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/4/24.
//

import UIKit

import SnapKit
import Then

final class TotalTimePickerView: UIPickerView {
    private let hours: [String] = ["1", "2", "3", "4", "5", "6"]
    
    private let titleLabel = UILabel().then {
        $0.textColor = .gray2
        $0.font = .iosText2Medium20
        $0.text = "시간"
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
        self.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(124.adjusted)
        }
    }
    
    private func configurePickerView() {
        self.backgroundColor = .clear
        self.delegate = self
        self.dataSource = self
    }
}

extension TotalTimePickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hours[row]
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
        
        if row == selectedRow {
            color = UIColor.whiteText
            font = UIFont.iosText1Medium22
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): color,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): font
        ]
        
        return NSAttributedString(string: hours[row], attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 53.adjusted
    }
}
