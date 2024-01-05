//
//  UIView+.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 12/23/23.
//
import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    func makeShadow (radius : CGFloat, offset : CGSize, opacity : Float){
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    
    func makeCornerRound (radius : CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func makeBorder (width : CGFloat ,color : UIColor ) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func showToast(message: String, at: CGFloat = 17) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = .gray8
        toastLabel.textColor = .whiteText
        toastLabel.textAlignment = .center
        toastLabel.font = .iosDetail4Medium12
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true
        
        let toastWidth = 248.adjusted
        let toastHeight = 43.adjusted
        toastLabel.frame = CGRect(x: self.frame.size.width / 2 - toastWidth / 2,
                                  y: self.frame.size.height - toastHeight - at.adjusted,
                                  width: toastWidth,
                                  height: toastHeight)
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(toastLabel)
        }
        
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
