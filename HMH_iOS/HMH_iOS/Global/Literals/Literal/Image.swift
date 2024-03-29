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
        static var icPoint: UIImage { .load(named: "ios_point_ic")}
    }
    
    enum TabBar {
        static var icChallenge: UIImage { .load(named: "challengeDisabled") }
        static var icChallengeSelected: UIImage { .load(named: "challengEnabled") }
        static var icHome: UIImage { .load(named: "homeDisabled") }
        static var icHomeSelected: UIImage { .load(named: "homeEnabled") }
        static var icMyPage: UIImage { .load(named: "mypageDisabled") }
        static var icMyPageSelected: UIImage { .load(named: "mypageEnabled") }
    }
    
    enum Home {
        static var blackholeFail: UIImage { .load(named: "blackhole_fail")}
    }
    
    enum Splash {
        static var splash: UIImage { .load(named: "ios_splash")}
    }
    
    enum Onboarding {
        static var signUpComplete: UIImage { .load(named: "img_ios_signUp")}
    }
    
    enum Login {
        static var onboarigFirst: UIImage { .load(named: "img_ios_onboarding_1")}
        static var onboarigSecond: UIImage { .load(named: "img_ios_onboarding_2")}
        static var onboarigThird: UIImage { .load(named: "img_ios_onboarding_3")}
    }
    
    enum myPage {
        static var icProfil: UIImage { .load(named: "ios_profil_image")}
        static var icBadge: UIImage { .load(named: "ios_badge_ic_disabled")}
        static var icJourney: UIImage { .load(named: "ios_journey_ic")}
        static var icStore: UIImage { .load(named: "ios_store_ic")}
        static var icArrowRight: UIImage { .load(named: "chevron_right")}
    }
    
    enum Challenge {
        static var icPlus: UIImage { .load(named: "Minus_XL") }
        static var icChallengeFail: UIImage { .load(named: "challenge_ic_fail") }
        static var icChallengeSuccess: UIImage { .load(named: "challenge_ic_success") }
        static var icAddNewChallengeBackground: UIImage { .load(named: "ios_add_new_challenge_img") }
        static var icSevenDaysChallengeBackground: UIImage { .load(named: "ios_sevenDays_challenge_img") }
        static var icFourteenDaysChallengeBackground: UIImage { .load(named: "img_ios_14") }
        static var icUnselected: UIImage { .load(named: "img_iOS_unselected") }
    }
    
    enum Alert {
        static var icChallengeAlert: UIImage { .load(named: "ios_challenge_alert_img") }
    }
    
    enum limitTime {
        static var icLimitTime: UIImage { .load(named: "ios_limit_time_img") }
    }
}
