//
//  Image.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/2/24.
//

import UIKit

enum ImageLiterals {
    enum NavigationBar {
        static var icArrowLeft: UIImage { .load(named: "ic_back")}
        static var icPoint: UIImage { .load(named: "ios_point")}
    }
    
    enum TabBar {
        static var icChallenge: UIImage { .load(named: "challengeDisabled") }
        static var icChallengeSelected: UIImage { .load(named: "challengEnabled") }
        static var icHome: UIImage { .load(named: "homeDisabled") }
        static var icHomeSelected: UIImage { .load(named: "homeEnabled") }
        static var icMyPage: UIImage { .load(named: "mypageDisabled") }
        static var icMyPageSelected: UIImage { .load(named: "mypageEnabled") }
    }
    
    enum Challenge {
        static var icPlus: UIImage { .load(named: "Minus_XL") }
    }
}

