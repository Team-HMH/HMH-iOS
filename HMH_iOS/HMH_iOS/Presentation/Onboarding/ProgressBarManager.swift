//
//  ProgressBarManager.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/8/24.
//

import UIKit

class ProgressBarManager {
    static let shared = ProgressBarManager()
    let progressBarView = OnboardingProgressView()
    
    var progress: Int = 0
    
    func updateProgress(step: Int) {
        progressBarView.progressAmount = step
    }
    
    func resetProgress() {
        progress = 0
        progressBarView.progressAmount = Int(progress)
    }
}
