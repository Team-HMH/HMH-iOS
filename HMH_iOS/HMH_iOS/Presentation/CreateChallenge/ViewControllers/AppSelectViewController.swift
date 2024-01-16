//
//  AppSelectViewController.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/10/24.
//

import UIKit

import SnapKit
import Then
import SwiftUI

final class AppSelectViewController: OnboardingBaseViewController {
    var hostingController: UIHostingController<HMHAppSelectButtonView>?
    
    private lazy var contentViewController : UIHostingController<some View> = {
        let model = BlockingApplicationModel.shared
        let hostingController = UIHostingController(
            rootView: HMHAppSelectButtonView()
                .environmentObject(model)
        )
        return hostingController
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUI()
        configureAppSelectView()
    }
    
    private func setUI(){
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        nextButton.isHidden = true
        view.addSubview(contentViewController.view)
    }
    
    private func setConstraints() {
        contentViewController.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.adjusted)
            $0.bottom.equalToSuperview().inset(53.adjusted)
        }
    }
    
    private func configureAppSelectView() {
        view.backgroundColor = .background
        step = 5
        mainTitleText = StringLiteral.OnboardigMain.appSelect
        subTitleText = StringLiteral.OnboardigSub.appSelect
    }
}
