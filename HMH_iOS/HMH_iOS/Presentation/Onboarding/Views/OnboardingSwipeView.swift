//
//  OnboardingSwipeView.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/6/24.
//

import UIKit

import SnapKit
import Then

final class OnboardingSwipeView: UIView {
    private var timer: Timer?
    private var currentPage: Int = 0
    
    let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentSize = CGSize(width: (375 * 3).adjustedWidth, height: 380.adjustedHeight)
    }
    
    let pageControl = UIPageControl().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfPages = 3
        $0.currentPage = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setDelegate()
        startAutoScroll()
        setImageView()
    }
    
    deinit {
        stopAutoScroll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegate() {
        scrollView.delegate = self
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubviews(scrollView, pageControl)
    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(380.adjustedHeight)
        }
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setImageView() {
        for i in 0..<3 {
            let pageView = UIImageView().then {
                $0.image = [ImageLiterals.TabBar.icHome, ImageLiterals.TabBar.icChallenge, ImageLiterals.TabBar.icChallengeSelected][i]
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.contentMode = .scaleAspectFit
            }
            
            scrollView.addSubview(pageView)
            
            pageView.snp.makeConstraints {
                $0.top.equalTo(scrollView.snp.top)
                $0.size.equalToSuperview()
                $0.leading.equalTo(scrollView.snp.leading).offset(375.adjusted * CGFloat(i))
            }
        }
    }
    
    private func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func nextPage() {
        currentPage = (currentPage + 1) % 3
        scrollView.setContentOffset(CGPoint(x: (scrollView.frame.width.adjusted * CGFloat(currentPage)), y: 0), animated: true)
        pageControl.currentPage = currentPage
    }
}

extension OnboardingSwipeView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x.adjusted / scrollView.frame.width.adjusted)
        pageControl.currentPage = currentPage
    }
}
