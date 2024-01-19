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
    let provider = Providers.challengeProvider
    var app: [App] = []
    var goalTime: Int = 0
    var progress: Float = 0
    
    private let totalGoalTimeLabel = UILabel().then {
        $0.font = .iosDetail4Medium12
        $0.text = StringLiteral.Home.totalGoalUsingTime
        $0.textColor = .gray1
    }
    private let goalTimeLabel = UILabel().then {
        $0.font = .iosTitle2Semibold24
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
        LoadTodayChallenge()
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
    
    func calculateTotalUsageTime(appUsingTimeList: [App]) -> Int {
        var totalUsageTime = 0
        for data in appUsingTimeList {
            totalUsageTime = totalUsageTime + Int(data.usageTime)
            print("🥺", totalUsageTime)
        }
        return totalUsageTime
    }
    
    func bindData(data: GetDummyResponseDTO) {
        let totalUsedTime = calculateTotalUsageTime(appUsingTimeList: data.apps)
        
        let remindTime = convertMillisecondsToHoursAndMinutes(milliseconds: Int(totalUsedTime) - Int(self.goalTime))
        
        print("🥺", totalUsedTime)
        print("🥺", remindTime)
        
        if remindTime.hours == 0 {
            usableLabel.text = "\(remindTime.minutes)분"
        } else if remindTime.minutes == 0 {
            usableLabel.text = "\(remindTime.hours)시간"
        } else {
            usableLabel.text = "\(remindTime.hours)시간 \(remindTime.minutes)분"
        }
        
        if Int(totalUsedTime) <= self.goalTime {
            usableLabel.text = "0분"
        }
        
        totalProgressBar.setProgress(0, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let progress = Float(totalUsedTime) / Float(self.goalTime)
            self.totalProgressBar.setProgress(progress, animated: true)
        }
    }
    
    func HourOrMinuteConvert(data: GetHomeChallengeResponseDTO) -> String {
        let convertedGoalTime = convertMillisecondsToHoursAndMinutes(milliseconds: data.goalTime)
        if convertedGoalTime.hours == 0 {
            return "\(convertedGoalTime.minutes)분"
        } else if convertedGoalTime.minutes == 0 {
            return "\(convertedGoalTime.hours)시간"
        } else {
            return "\(convertedGoalTime.hours)시간 \(convertedGoalTime.minutes)분"
        }
    }
}

extension MyGoalTimeCell {
    func LoadTodayChallenge() {
        provider.request(target: .getdailyChallenge, instance: BaseResponse<GetHomeChallengeResponseDTO>.self, viewController: HomeViewController()) { [self] data in
            guard let data = data.data else { return }
            self.goalTimeLabel.text = "\(HourOrMinuteConvert(data: data))"
            self.goalTime = data.goalTime
        }
    }
}
