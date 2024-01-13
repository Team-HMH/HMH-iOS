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
    private let picker = SpecificTimePickerView()
    
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
        self.addSubviews(picker)
    }
    
    private func setConstraints() {
        picker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(335.adjusted)
        }
    }
    
    private func configureView() {
        self.backgroundColor = .background
    }
}
