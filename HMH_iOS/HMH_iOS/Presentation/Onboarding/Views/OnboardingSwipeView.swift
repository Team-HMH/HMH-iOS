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
    let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
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
        setImageView()
    }
    
    private func setHierarchy() {
        self.addSubviews(scrollView, pageControl)
    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(380)
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
                $0.width.equalTo(375)
                $0.height.equalTo(scrollView.snp.height)
                $0.leading.equalTo(scrollView.snp.leading).offset(375 * CGFloat(i))
            }
        }
        
        scrollView.contentSize = CGSize(width: 375 * 3, height: frame.height)
    }
}

extension OnboardingSwipeView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
        pageControl.currentPage = currentPage
    }
}
