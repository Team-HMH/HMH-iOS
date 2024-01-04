//
//  TabBarController.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/3/24.
//
import UIKit

import SnapKit
import Then

final class TabBarController: UITabBarController {
    private let tabBarView = UIView().then {
        $0.backgroundColor = .gray7
        $0.makeCornerRound(radius: 8)
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setTabBarHeight()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
        setTabBar()
    }
    
    private func setHierarchy() {
        tabBar.addSubview(tabBarView)
    }
    
    private func setConstraints() {
        tabBarView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
    private func makeTabBar(viewController: UIViewController,
                            title: String,
                            tabBarImg: UIImage,
                            tabBarSelectedImg: UIImage,
                            renderingMode: UIImage.RenderingMode) -> UIViewController {
        
        let tab = UINavigationController(rootViewController: viewController)
        tab.isNavigationBarHidden = true
        tab.tabBarItem = UITabBarItem(title: title,
                                      image: tabBarImg.withRenderingMode(renderingMode),
                                      selectedImage: tabBarSelectedImg.withRenderingMode(renderingMode))
        return tab
    }
    
    private func setTabBarHeight() {
        let safeAreaHeight = view.safeAreaInsets.bottom
        let tabBarHeight: CGFloat = 58.0
        tabBar.frame.size.height = tabBarHeight + safeAreaHeight
        tabBar.frame.origin.y = view.frame.height - tabBarHeight - safeAreaHeight
    }
    
    private func setTabBar() {
        let challenge = makeTabBar(
            viewController: ChanllengeViewController(),
            title: "챌린지",
            tabBarImg: ImageLiterals.TabBar.icChallenge,
            tabBarSelectedImg: ImageLiterals.TabBar.icChallengeSelected,
            renderingMode: .alwaysOriginal
        )
        let home = makeTabBar(
            viewController: HomeViewController(),
            title: "홈",
            tabBarImg: ImageLiterals.TabBar.icHome,
            tabBarSelectedImg: ImageLiterals.TabBar.icHomeSelected,
            renderingMode: .alwaysOriginal
        )
        let myPage = makeTabBar(
            viewController: MyPageViewController(),
            title: "마이페이지",
            tabBarImg: ImageLiterals.TabBar.icMyPage,
            tabBarSelectedImg: ImageLiterals.TabBar.icMyPageSelected,
            renderingMode: .alwaysOriginal
        )
        
        let tabs = [challenge, home, myPage]
        self.setViewControllers(tabs, animated: false)
        tabBar.isTranslucent = false
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.iosDetail2Medium12,
            .foregroundColor: UIColor.gray2
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.iosDetail2Medium12,
            .foregroundColor: UIColor.whiteBtn
        ]
        
        tabs.forEach { tabBarItem in
            tabBarItem.tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)
            tabBarItem.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
            tabBarItem.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        }
    }
}
