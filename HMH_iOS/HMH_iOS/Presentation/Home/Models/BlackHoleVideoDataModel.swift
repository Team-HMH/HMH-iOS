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

var blackHoleModel: [BlackHoleVideoDataModel] = [
    .init(image: nil,
          videoItem: Bundle.main.url(forResource: "1StepBlackHole", withExtension: "mp4")!,
          text: StringLiteral.Home.blackHoleFirstStep),
    .init(image: nil,
          videoItem: Bundle.main.url(forResource: "2StepBlackHole", withExtension: "mp4")!,
          text: StringLiteral.Home.blackHoleSecondStep),
    .init(image: nil,
          videoItem: Bundle.main.url(forResource: "3StepBlackHole", withExtension: "mp4")!,
          text: StringLiteral.Home.blackHoleThridStep),
    .init(image: nil,
          videoItem: Bundle.main.url(forResource: "4StepBlackHole", withExtension: "mp4")!,
          text: StringLiteral.Home.blackHoleFourthStep),
    .init(image: nil,
          videoItem: Bundle.main.url(forResource: "4StepBlackHole", withExtension: "mp4")!,
          text: StringLiteral.Home.blackHoleFifthStep),
    .init(image: ImageLiterals.Home.blackholeFail,
          videoItem: nil,
          text: StringLiteral.Home.blackHoleFailure)
]
