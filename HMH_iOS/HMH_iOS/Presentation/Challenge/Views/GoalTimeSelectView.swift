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
    
    var selectedValue = FamilyActivitySelection()
    
    private let titlelabel = UILabel().then {
        $0.font = .iosTitle1Semibold22
        $0.textColor = .whiteText
        $0.text = StringLiteral.Challenge.GoalTime.titleText
        $0.numberOfLines = 2
    }
    private let subTitlelabel = UILabel().then {
        $0.font = .iosDetail1Regular14
        $0.textColor = .whiteText
        $0.text = StringLiteral.Challenge.GoalTime.titleText
        $0.numberOfLines = 2
    }
    private let picker = SpecificTimePickerView()
    private let progressBar = ProgressBarManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        configureView()
        progressBar.updateProgress(step: 6)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubviews(titlelabel, subTitlelabel, progressBar.progressBarView, picker)
    }
    
    private func setConstraints() {
        
        progressBar.progressBarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(62)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        titlelabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(145.adjusted)
            $0.leading.equalToSuperview().offset(21.adjusted)
        }
        
        subTitlelabel.snp.makeConstraints {
            $0.top.equalTo(titlelabel.snp.bottom).offset(7)
            $0.leading.equalTo(titlelabel.snp.leading)
        }
        
        picker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(335.adjusted)
        }
    }
    
    private func configureView() {
        self.backgroundColor = .background
        
    }
    
}
