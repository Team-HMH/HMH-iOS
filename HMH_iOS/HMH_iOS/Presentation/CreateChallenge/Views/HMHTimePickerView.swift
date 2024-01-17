//
//  TotalTimePickerView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/4/24.
//

import UIKit

import SnapKit
import Then

protocol TimePickerDelegate: AnyObject {
    func updateAvailability(selectedValue: Int)
}

final class HMHTimePickerView: UIPickerView {
    @frozen
    enum TimePickerType {
        case totalTime
        case specificTime
        case specificMinute
    }
    
    private var type: TimePickerType = .totalTime
    private var selectedValue = 0
    var isChanged: Bool = false
    private var timeList: [String] = []
    
    weak var totalTimePickerDelegate: TimePickerDelegate?
    
    init(type: TimePickerType) {
        super.init(frame: .zero)
        self.type = type
        configurePickerView()
        setDelegate()
        configureList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureList() {
        switch type {
        case .totalTime:
            timeList = ["1", "2", "3", "4", "5", "6"]
            
        case .specificTime:
            timeList = ["0", "1"]
            
        case .specificMinute:
            timeList = Array(0...59).map { String($0)}
        }
    }
    
    private func setDelegate() {
        self.delegate = self
        self.dataSource = self
    }
    
    private func configurePickerView() {
        self.backgroundColor = .clear
    }
}

extension HMHTimePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeList[row]
    }
    
    var selectedRow: Int {
        return self.selectedRow(inComponent: 0)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.reloadComponent(component)
        isChanged = true
        selectedValue = Int(timeList[row]) ?? 0
        self.totalTimePickerDelegate?.updateAvailability(selectedValue: selectedValue)
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
        
        return NSAttributedString(string: timeList[row], attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 53.adjustedHeight
    }
}

extension HMHTimePickerView: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeList.count
    }
}


