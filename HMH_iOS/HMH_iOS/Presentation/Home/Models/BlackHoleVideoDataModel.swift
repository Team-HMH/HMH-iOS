//
//  BlackHoleVideoDataModel.swift
//  HMH_iOS
//
//  Created by 김보연 on 1/10/24.
//

import Foundation
import AVFoundation
import UIKit

struct BlackHoleVideoDataModel {
    let image: UIImage?
    let videoItem: URL?
    let text: String
}

enum BlackHoleDataType: Int{
    case firstStep = 0
    case secondStep = 1
    case thirdStep = 2
    case fourthStep = 3
    case fifthStep = 4
    case fail = 5
}


