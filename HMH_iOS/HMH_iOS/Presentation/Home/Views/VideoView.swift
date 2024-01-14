import Foundation
import UIKit
import AVFoundation

class VideoView: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(videoHandler: VideoHandler) {
        super.init(frame: .zero)
        self.avPlayer = videoHandler.avPlayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setPlayerLayer()
    }
    
    private func setPlayerLayer() {
        self.layer.addSublayer(playerLayer)
        playerLayer.accessibilityFrame = self.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = self.bounds
        guard let player = self.avPlayer else { return }
        playerLayer.player = player
    }
    
    var avPlayer: AVPlayer?
    private let playerLayer = AVPlayerLayer()
}
