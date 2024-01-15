//
//  MyGoalTimeCell.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class MyGoalTimeCell: UICollectionViewCell {
    
    static let identifier = "MyGoalTimeCell"
    
    var progress: Float = 0
    
    private let totalGoalTimeLabel = UILabel().then {
        $0.font = .iosDetail4Medium12
        $0.text = StringLiteral.Home.totalGoalUsingTime
        $0.textColor = .gray1
    }
    private let goalTimeLabel = UILabel().then {
        $0.font = .iosTitle2Semibold24
        $0.text = "4시간"
        $0.textColor = .whiteText
    }
    private let usableLabel = UILabel().then {
        $0.font = .iosDetail3Semibold12
        $0.textColor = .whiteText
    }
    private let remainTimeLabel = UILabel().then {
        $0.font = .iosDetail4Medium12
        $0.text = StringLiteral.Home.remainedTimeUnit
        $0.textColor = .gray1
    }
    lazy var totalProgressBar = UIProgressView().then {
        $0.trackTintColor = .gray3
        $0.progressTintColor = .whiteText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubviews(totalGoalTimeLabel, goalTimeLabel, usableLabel, remainTimeLabel, totalProgressBar)
    }
    
    private func setConstraints() {
        totalGoalTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        goalTimeLabel.snp.makeConstraints {
            $0.top.equalTo(totalGoalTimeLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        usableLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(38)
            $0.trailing.equalTo(remainTimeLabel.snp.leading).offset(-5)
        }
        
        remainTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(38)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        totalProgressBar.snp.makeConstraints {
            $0.height.equalTo(6)
            $0.top.equalTo(remainTimeLabel.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func bindData(data: TotalAppUsingTimeDataModel) {
        let remindTime = convertMillisecondsToHoursAndMinutes(milliseconds: Int(data.onboardingTotalGoalTime) - Int(data.totalAppRemainedTime))
        if remindTime.hours == 0 {
            usableLabel.text = "\(remindTime.minutes)분"
        } else if remindTime.minutes == 0 {
            usableLabel.text = "\(remindTime.hours)시간"
        } else {
            usableLabel.text = "\(remindTime.hours)시간 \(remindTime.minutes)분"
        }
        
        if data.totalAppRemainedTime >= data.onboardingTotalGoalTime {
            usableLabel.text = "0분"
        }
        
        let progress = Float(data.totalAppRemainedTime) / Float(data.onboardingTotalGoalTime)
        self.progress = progress
        
        totalProgressBar.setProgress(0, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.totalProgressBar.setProgress(progress, animated: true)
        }
    }
}

