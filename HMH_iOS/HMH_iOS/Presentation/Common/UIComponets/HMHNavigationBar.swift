//
//  HMHNavigationBar.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/2/24.
//

import UIKit

import SnapKit
import Then

final class HMHNavigationBar: UIView {
    @frozen
    enum NavigationBarType {
        case onBoarding
        case logo
        case backButton
    }
    
    private weak var viewController: UIViewController?
    private let type: NavigationBarType

    init(_ viewController: UIViewController, leftItem type: NavigationBarType) {
        self.viewController = viewController
        self.type = type
        super.init(frame: .zero)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        setHierarchy()
        setConstraints()
    }

    func setHierarchy() {
    }

    func setConstraints() {
    }
}

