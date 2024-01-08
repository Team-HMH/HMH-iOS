//
//  OnboardingProgressView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingProgressView: UIProgressView {
    var progressAmount: Int = 0 {
        didSet {
            if oldValue > progressAmount {
                removeProgressBar()
            } else {
                addProgressBar()
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        configureProgressView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(4.adjusted)
        }
    }
    
    private func configureProgressView() {
        self.do {
            $0.trackTintColor = .gray2
            $0.progressTintColor = .bluePurpleProgress
        }
    }
    
    private func addProgressBar() {
        let startValue = Float(max(0, self.progressAmount - 1)) / 6.0
        let endValue = Float(self.progressAmount) / 6.0
        
        self.setProgress(startValue, animated: false)
        
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: { [unowned self] in
                self.setProgress(endValue, animated: true)
            })
        }
    }
    
    private func removeProgressBar() {
        let startValue = Float(min(6, self.progressAmount + 1)) / 6.0
        let endValue = Float(self.progressAmount) / 6.0
        
        self.setProgress(startValue, animated: false)
        
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: { [unowned self] in
                self.setProgress(endValue, animated: true)
            })
        }
    }
}
