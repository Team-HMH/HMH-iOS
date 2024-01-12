//
//  AppUsingProgressViewCell.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/11/24.
//

import UIKit

import SnapKit
import Then

final class AppUsingProgressViewCell: UICollectionViewCell {
    
    static let identifier = "AppUsingProgressViewCell"
    
    private let appStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 9
        $0.alignment = .center
    }
    private let appIconImageView = UIImageView().then {
        $0.backgroundColor = .whiteBtn
        $0.makeCornerRound(radius: 6.adjusted)
    }
    private let appLabelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .leading
    }
    private let appNameLabel = UILabel().then {
        $0.font = .iosDetail3Semibold12
        $0.textColor = .gray1
        $0.textAlignment = .left
    }
    private var appGoalTimeLabel = UILabel().then {
        $0.font = .iosDetail2Semibold13
        $0.textColor = .whiteText
        $0.textAlignment = .left
    }
    private let remainedTimeStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .center
    }
    private let appRemainedTimeLabel = UILabel().then {
        $0.font = .iosText4Semibold16
        $0.textColor = .whiteText
        $0.textAlignment = .right
    }
    private let remainedTimeUnitLabel = UILabel().then {
        $0.font = .iosText6Medium14
        $0.textColor = .gray2
        $0.textAlignment = .center
        $0.text = StringLiteral.Home.remainedTimeUnit
    }
    lazy var appProgressBar = UIProgressView().then {
        $0.trackTintColor = .gray7
        $0.progressTintColor = .bluePurpleOpacity70
        $0.clipsToBounds = true
        $0.progressViewStyle = .bar
        $0.layer.cornerRadius = 6.adjusted
        $0.layer.sublayers![1].masksToBounds = true
        $0.layer.sublayers![1].cornerRadius = 6.adjusted
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
        self.addSubview(appProgressBar)
        appProgressBar.addSubviews(appStackView, remainedTimeStackView)
        appStackView.addArrangeSubViews([appIconImageView, appLabelStackView])
        appLabelStackView.addArrangeSubViews([appNameLabel, appGoalTimeLabel])
        remainedTimeStackView.addArrangeSubViews([appRemainedTimeLabel, remainedTimeUnitLabel])
    }
    
    private func setConstraints() {
        appProgressBar.snp.makeConstraints {
            $0.height.equalTo(75.adjusted)
            $0.horizontalEdges.equalToSuperview().inset(20.adjustedWidth)
        }
        
        appStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18.adjusted)
            $0.centerY.equalToSuperview()
        }
        
        appIconImageView.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        remainedTimeStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(19.adjusted)
            $0.centerY.equalToSuperview()
        }
    }
    
    func bindData(data: AppUsingTimeModel) {
        self.appGoalTimeLabel.text = "\(HourOrMinuteConvert(data: data))시간"
        self.appRemainedTimeLabel.text = "\(finalTimeConvert(data: data))분"
        self.appNameLabel.text = data.usingAppName
        self.appIconImageView.image = data.usingAppIcon
        updateProgressBar(data: data)
        HourOrMinuteConvert(data: data)
        finalTimeConvert(data: data)
        
        appProgressBar.setProgress(0, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let progress = Float(data.usedTime) / Float(data.appGoalTime)
            self.appProgressBar.setProgress(progress, animated: true)
        }
    }
    
    func convertMillisecondsToHoursAndMinutes(milliseconds: Int) -> (hours: Int, minutes: Int) {
        let totalMinutes = milliseconds / (1000 * 60)
        let hours = totalMinutes / 60
        let remainingMinutes = totalMinutes % 60
        return (hours, remainingMinutes)
    }
    
    func updateProgressBar(data: AppUsingTimeModel) {
        if data.appGoalTime != 0 {
            let progress = Float(data.usedTime) / Float(data.appGoalTime)
            appProgressBar.progress = progress
        } else {
            appProgressBar.progress = 0.0
        }
        
        if data.usedTime >= data.appGoalTime {
            appProgressBar.progress = 1
        }
    }
    
    func HourOrMinuteConvert(data: AppUsingTimeModel) {
        let convertedGoalTime = convertMillisecondsToHoursAndMinutes(milliseconds: data.appGoalTime)
        if convertedGoalTime.hours == 0 {
            self.appGoalTimeLabel.text = "\(convertedGoalTime.minutes)분"
        } else if convertedGoalTime.minutes == 0 {
            self.appGoalTimeLabel.text = "\(convertedGoalTime.hours)시간"
        } else {
            self.appGoalTimeLabel.text = "\(convertedGoalTime.hours)시간 \(convertedGoalTime.minutes)분"
        }
    }
    
    func finalTimeConvert(data: AppUsingTimeModel) {
        let appRemainedTime = max(0, Int(data.appGoalTime) - Int(data.usedTime))
        let convertedTime = convertMillisecondsToHoursAndMinutes(milliseconds: appRemainedTime)
        
        if convertedTime.hours == 0 {
            appRemainedTimeLabel.text = "\(convertedTime.minutes)분"
        } else {
            appRemainedTimeLabel.text = "\(convertedTime.hours)시간 \(convertedTime.minutes)분"
        }
        
        if data.usedTime >= data.appGoalTime {
            appRemainedTimeLabel.text = "남은 시간 없음"
        }
    }
}
