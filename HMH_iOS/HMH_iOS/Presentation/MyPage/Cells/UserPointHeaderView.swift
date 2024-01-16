//
//  UserPointHeaderView.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/9/24.
//

import UIKit

import SnapKit
import Then

final class UserPointHeaderView: UICollectionReusableView {
    
    static let identifier = "UserPointHeaderView"
    
    private let provider = Providers.myPageProvider
    
    private let userStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 15.adjusted
        $0.alignment = .center
    }
    
    private let userprofilView = UIView().then {
        $0.backgroundColor = .gray6
        $0.makeCornerRound(radius: 27)
    }
    
    private let userLabel = UILabel().then {
        $0.font = .iosTitle4Semibold20
        $0.textColor = .whiteText
    }
    
    private let pointBadgeView = UIView().then {
        $0.backgroundColor = .gray6
        $0.makeCornerRound(radius: 7.adjusted)
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = .gray4
    }
    
    private let myPointButtonStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 8.adjusted
        $0.axis = .vertical
    }
    
    private let myPointLabel = UILabel().then {
        $0.font = .iosText6Medium14
        $0.text = StringLiteral.myPage.point
        $0.textColor = .whiteText
    }
    
    private let pointStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 7
        $0.alignment = .center
    }
    
    private let pointLabel = UILabel().then {
        $0.font = .iosTitle4Semibold20
        $0.textColor = .gray2
        $0.text = "P"
    }
    
    private let countPointLabel = UILabel().then {
        $0.font = .iosTitle4Semibold20
        $0.textColor = .whiteText
        $0.textAlignment = .right
    }
    
    private let myBadgeButtonStackView = UIStackView().then {
        $0.alignment = .center
        $0.axis = .vertical
        $0.spacing = 8.adjusted
    }
    
    private let badgeLabel = UILabel().then {
        $0.font = .iosText6Medium14
        $0.text = StringLiteral.myPage.badge
        $0.textColor = .gray2
    }
    
    private let badgeImageView = UIImageView().then {
        $0.image = ImageLiterals.myPage.icBadge
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        self.addSubviews(userStackView, pointBadgeView)
        userStackView.addArrangeSubViews([userprofilView, userLabel])
        pointBadgeView.addSubviews(myPointButtonStackView, lineView, myBadgeButtonStackView)
        myPointButtonStackView.addArrangeSubViews([myPointLabel, pointStackView])
        pointStackView.addArrangeSubViews([countPointLabel, pointLabel])
        myBadgeButtonStackView.addArrangeSubViews([badgeLabel, badgeImageView])
        
    }
    
    func setConstraints() {
        userStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11.adjustedHeight)
            $0.leading.equalToSuperview().inset(20.adjustedHeight)
        }
        
        userprofilView.snp.makeConstraints {
            $0.size.equalTo(54.adjusted)
        }
        
        pointBadgeView.snp.makeConstraints {
            $0.top.equalTo(userStackView.snp.bottom).offset(25.adjusted)
            $0.bottom.equalToSuperview().inset(22.adjusted)
            $0.horizontalEdges.equalToSuperview().inset(20.adjustedWidth)
        }
        
        myPointButtonStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(142.adjusted)
            $0.leading.equalToSuperview().inset(12.adjusted)
        }
        
        lineView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(57.adjusted)
        }
        
        myBadgeButtonStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(145.adjusted)
            $0.trailing.equalToSuperview().offset(-12.adjusted)
        }
        
    }
    
    private func configureView() {
        self.backgroundColor = .background
    }
}

extension UserPointHeaderView {
    func getUserDataAPI() {
        provider.request(target: .getUserData,
                         instance: BaseResponse<GetUserDataResponseDTO>.self,
                         viewController: MyPageViewController()) { data in
            guard let data = data.data else { return }
            self.userLabel.text = data.name
            self.countPointLabel.text = "\(data.point)"
        }
    }
}
