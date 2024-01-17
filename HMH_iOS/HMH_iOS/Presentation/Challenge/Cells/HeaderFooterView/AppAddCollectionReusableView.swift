//
//  AppAddCollectionReusableView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/8/24.
//

import UIKit
import SwiftUI

import SnapKit
import Then

class AppAddCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "AppAddCollectionReusableView"
    var hostingController: UIHostingController<AppAddButtonView>?
    
    private lazy var contentViewController : UIHostingController<some View> = {
        let model = BlockingApplicationModel.shared
        let hostingController = UIHostingController(
            rootView: AppAddButtonView()
                .environmentObject(model)
        )
        return hostingController
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubviews(contentViewController.view)
    }
    
    private func setConstraints() {
        contentViewController.view.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    private func configureView() {
        contentViewController.view.backgroundColor = .clear
    }
}
