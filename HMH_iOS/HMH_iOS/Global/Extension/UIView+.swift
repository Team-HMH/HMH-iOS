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
}
