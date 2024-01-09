//
//  TabBarController.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/3/24.
//
import UIKit
import SwiftUI
import FamilyControls

import SnapKit
import Then

final class TabBarController: UITabBarController {
    
    private let authorizationCenter = AuthorizationCenter.shared
    
    private let tabBarView = UIView().then {
        $0.backgroundColor = .gray7
        $0.makeCornerRound(radius: 8.adjusted)
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestAuthorization()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTabBarHeight()
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        tabBar.addSubview(tabBarView)
    }
    
    private func setConstraints() {
        tabBarView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            
            if UIScreen.main.isLongerThan812pt {
                $0.height.equalTo(100.adjusted)
            } else {
                $0.height.equalTo(64)
            }
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
        let safeAreaHeight = view.safeAreaInsets.bottom.adjustedHeight
        let tabBarHeight: CGFloat = UIScreen.main.isLongerThan812pt ? 52.0.adjusted : 58.0.adjusted
        tabBar.frame.size.height = tabBarHeight + safeAreaHeight
        tabBar.frame.origin.y = view.frame.height - tabBarHeight - safeAreaHeight

    }
    
    private func setTabBar() {
        let challenge = makeTabBar(
            viewController: ChallengeViewController(),
            title: StringLiteral.TabBar.challengeTitle,
            tabBarImg: ImageLiterals.TabBar.icChallenge,
            tabBarSelectedImg: ImageLiterals.TabBar.icChallengeSelected,
            renderingMode: .alwaysOriginal
        )
        let home = makeTabBar(
            viewController: HomeViewController(),
            title: StringLiteral.TabBar.homeTitle,
            tabBarImg: ImageLiterals.TabBar.icHome,
            tabBarSelectedImg: ImageLiterals.TabBar.icHomeSelected,
            renderingMode: .alwaysOriginal
        )
        let myPage = makeTabBar(
            viewController: MyPageViewController(),
            title: StringLiteral.TabBar.myPageTitle,
            tabBarImg: ImageLiterals.TabBar.icMyPage,
            tabBarSelectedImg: ImageLiterals.TabBar.icMyPageSelected,
            renderingMode: .alwaysOriginal
        )
        
        let tabs = [challenge, home, myPage]
        self.setViewControllers(tabs, animated: false)
        tabBar.isTranslucent = false
        
        tabBar.unselectedItemTintColor = .gray2
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.iosDetail4Medium12,
            .foregroundColor: UIColor.gray2
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.iosDetail3Semibold12,
            .foregroundColor: UIColor.whiteBtn
        ]
        
        tabs.forEach { tabBarItem in
            tabBarItem.tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)
            tabBarItem.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
            if UIScreen.main.isLongerThan812pt {
                tabBarItem.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3.adjusted)
            } else {
                tabBarItem.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1.adjusted)
            }
        }
    }
    
    private func requestAuthorization() {
        if authorizationCenter.authorizationStatus == .approved {
            print("ScreenTime 권한 허용 완료")
        } else {
            Task {
                do {
                    try await authorizationCenter.requestAuthorization(for: .individual)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
