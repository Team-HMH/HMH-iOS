//
//  UIScreen+.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 12/29/23.
//

import UIKit

extension UIScreen {
    var isWiderThan375pt: Bool { self.bounds.size.width > 375 }
    var isLongerThan812pt: Bool {self.bounds.size.height >= 812}
}

