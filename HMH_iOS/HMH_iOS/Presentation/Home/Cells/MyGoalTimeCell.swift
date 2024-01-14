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
        $0.text = "3시간"
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
    
    var totalTime: Int = 21600000
    
    func bindData(data: TotalAppUsingTimeDataModel) {
//        self.usableLabel.text = "\(convertMillisecondsToHoursAndMinutes(milliseconds: calculateTotalUsageTime(data: data)))분"
        let remindTime = convertMillisecondsToHoursAndMinutes(milliseconds: Int(data.onboardingTotalGoalTime - data.totalAppUsingTime))
//        self.usableLabel.text = "\(remindTime.hours)분"
//        finalTimeConvert(data: data)
//        updateTotalUsageTime(data: data)
        
        totalProgressBar.setProgress(0, animated: false)
//        let progress = Float(self.calculateTotalUsageTime(data: data)) / Float(self.totalTime)
        let progress = data.progressValue
        self.progress = progress
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.totalProgressBar.setProgress(progress, animated: true)
        }
    }
    
    func calculateTotalUsageTime(data: [AppUsingTimeModel]) -> Int {
        return data.reduce(0) { $0 + Int($1.usedTime) }
    }
    
    func updateTotalUsageTime(data: [AppUsingTimeModel]) {
        let totalProgress = Float(calculateTotalUsageTime(data: data)) / Float(totalTime)
        DispatchQueue.main.async {
            self.totalProgressBar.progress = totalProgress
            if self.calculateTotalUsageTime(data: data) >= self.totalTime {
                self.totalProgressBar.progress = 1
            }
        }
    }
}

