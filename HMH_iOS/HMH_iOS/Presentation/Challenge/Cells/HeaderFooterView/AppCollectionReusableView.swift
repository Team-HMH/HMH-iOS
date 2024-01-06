//
//  AppCollectionReusableView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/6/24.
//

import UIKit

class AppCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "AppCollectionReusableView"
    
    let titleLabel = UILabel().then {
        $0.text = "앱 잠금"
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .white
    }
    
    let deleteButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.setTitleColor(.blue, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        self.addSubviews(titleLabel, deleteButton)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(7)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
}
