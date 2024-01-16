import Foundation
import AVFoundation

class VideoHandler: NSObject {
    var avPlayer: AVPlayer? = AVPlayer()
    
    override init() {
        super.init()
        self.addObserver()
    }
    
    func bindVideoItem(videoURL: URL) {
        DispatchQueue.main.async {
            let avPlayerItem = AVPlayerItem(url: videoURL)
            self.avPlayer?.replaceCurrentItem(with: avPlayerItem)
            self.avPlayer?.play()
        }
    }
    
    func removeEndTimeObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: .AVPlayerItemDidPlayToEndTime,
                                                  object: self.avPlayer?.currentItem)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: self.avPlayer?.currentItem,
                                               queue: nil) { [weak self] (_) in
            guard let self else { return }
            self.avPlayer?.seek(to: CMTime.zero)
            self.avPlayer?.play()
        }
    }
    
    func playVideo() {
        self.avPlayer?.play()
    }
    
    func pauseVideo() {
        self.avPlayer?.pause()
    }
    
    func disposeVideo() {
        self.avPlayer?.pause()
        self.avPlayer?.replaceCurrentItem(with: nil)
    }
}
