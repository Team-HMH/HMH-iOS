//
//  BlackHoleImageCell.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/11/24.
//

import UIKit
import AVFoundation

import SnapKit
import Then


final class BlackHoleImageCell: UICollectionViewCell {
    
    static let identifier = "BlackHoleImageCell"
    
    private var videoHandler = VideoHandler()
    private let blackHoleImageView = UIImageView()
    private lazy var blackHoleVideoView = VideoView(videoHandler: videoHandler)
    
    private let homeBlackHoleStateLabel = UILabel().then {
        $0.font = .iosTitle3Semibold22
        $0.textColor = .whiteText
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubviews(blackHoleImageView, blackHoleVideoView, homeBlackHoleStateLabel)
    }
    
    private func setConstraints() {
        blackHoleImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(blackHoleImageView.snp.width)
        }
        
        blackHoleVideoView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(blackHoleImageView.snp.width)
        }
        
        homeBlackHoleStateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23.adjusted)
            $0.leading.equalToSuperview().inset(21.adjusted)
        }
    }
    
    func configureCell (image: UIImage? = nil,
                        videoUrl: URL?,
                        text: String){
        homeBlackHoleStateLabel.text = text
        homeBlackHoleStateLabel.setTextWithLineHeight(text: text, lineHeight: 33.adjusted)
        homeBlackHoleStateLabel.textAlignment = .left
        
        DispatchQueue.main.async {
            if let image {
                self.blackHoleImageView.isHidden = false
                self.blackHoleVideoView.isHidden = true
                self.blackHoleImageView.image = image
            } else {
                self.blackHoleVideoView.isHidden = false
                self.blackHoleImageView.isHidden = true
            }
            if let videoUrl {
                self.blackHoleVideoView.isHidden = false
                self.videoHandler.bindVideoItem(videoURL: videoUrl)
            } else {
                self.blackHoleVideoView.isHidden = true
            }
        }
    }
}
