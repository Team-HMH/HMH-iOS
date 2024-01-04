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
    }
    
    enum TabBar {
        static var icChallenge: UIImage { .load(named: "first_default") }
        static var icChallengeSelected: UIImage { .load(named: "first_active") }
        static var icHome: UIImage { .load(named: "second_default") }
        static var icHomeSelected: UIImage { .load(named: "second_active") }
        static var icMyPage: UIImage { .load(named: "third_default") }
        static var icMyPageSelected: UIImage { .load(named: "third_active") }
    }
}

