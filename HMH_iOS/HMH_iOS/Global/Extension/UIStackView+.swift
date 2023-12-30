//
//  UIStackView+.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 12/29/23.
//

import UIKit

extension UIStackView {
    func addArrangeSubViews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
