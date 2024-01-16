//
//  AlertDelegate.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/7/24.
//

import Foundation

protocol AlertDelegate: AnyObject {
    func enabledButtonTapped()
    func alertDismissTapped()
    func confirmButtonTapped()
}
