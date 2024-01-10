//
//  TotalTimePickerView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/4/24.
//

import UIKit

import SnapKit
import Then

protocol TotalTimePickerDelegate: AnyObject {
    func updateAvailability()
}

final class TotalTimePickerView: UIPickerView {
    weak var totalTimePickerDelegate: TotalTimePickerDelegate?
    
    private let hours: [String] = ["1", "2", "3", "4", "5", "6"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        configurePickerView()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegate() {
        self.delegate = self
        self.dataSource = self
    }
    
    private func configurePickerView() {
        self.backgroundColor = .clear
    }
}

extension TotalTimePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hours[row]
    }
    
    var selectedRow: Int {
        return self.selectedRow(inComponent: 0)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.reloadComponent(component)
        self.totalTimePickerDelegate?.updateAvailability()
        print(hours[row])
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
        return 53.adjustedHeight
    }
}

extension TotalTimePickerView: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hours.count
    }
}


