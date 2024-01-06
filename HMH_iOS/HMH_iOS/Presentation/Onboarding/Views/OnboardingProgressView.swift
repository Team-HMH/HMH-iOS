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
    var progressAmount: Int = 0
    
    init(progressAmount: Int) {
        super.init(frame: .zero)
        self.progressAmount = progressAmount
        
        configureProgressView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(4.adjustedHeight)
        }
    }
    
    private func configureProgressView() {
        self.do {
            $0.trackTintColor = .gray2
            $0.progressTintColor = .bluePurpleProgress
        }
    }
    
    func setProgressBar() {
        self.setProgress(Float(self.progressAmount-1) / 6.0, animated: false)
        
        DispatchQueue.main.async() {
            UIView.animate(withDuration: 3, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: { [unowned self] in
                self.setProgress(Float(self.progressAmount) / 6.0, animated: true)
            })
        }
    }
}

