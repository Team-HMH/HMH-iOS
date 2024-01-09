//
//  String.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/5/24.
//

import Foundation

enum StringLiteral {
    enum TabBar {
        static var challengeTitle = "챌린지"
        static var homeTitle = "홈"
        static var myPageTitle = "마이페이지"
    }
    
    enum Challenge {
        static var NavigationBarTitle = "나의 챌린지"
        enum Date {
            static var dateHeaderTitle = "3시간"
            static var dateHeaderSubTitle = "목표 이용시간"
        }
        enum AppList {
            static var appListHeaderTitle = "앱 잠금"
            static var appListHeaderButtonText = "삭제"
        }
        enum Idetifier {
            static var titleHeaderViewId = "TitleSectionHeader"
            static var appListHeaderViewId = "AppSectionHeader"
            static var backgroundViewId = "GrayBackground"
            static var appAddFooterViewID = "appAddFooter"
        }
    }
    enum AlertButton {
        static let confirm = "확인"
        static let cancel = "취소"
        static let close = "닫기"
    }
    
    enum AlertTitle {
        static let logout = "HMH을 로그아웃 하실 건가요?"
        static let quit = "HMH을 탈퇴 하실 건가요?"
    }
    
    enum AlertDescription {
        static let quit = "회원탈퇴 후 유저의 정보는 30일 동안 임시보관 후 영구 삭제됩니다."
    }
    
    enum OnboardingButton {
        static let next = "다음"
        static let permission = "권한 허용하러 가기"
        static let selectApp = "앱 선택하기"
        static let selectComplete = "선택 완료"
        static let complete = "완료"
        static let confirm = "확인"
    }
    
    enum OnboardigMain {
        static let TimeSurvey = "하루 평균 휴대폰을 얼마나 사용하나요?"
        static let problemSurvey = "휴대폰을 사용할 때 어떤 문제를 겪고 있나요?"
    }
    
    enum OnboardigSub {
        static let problemSurvey = "해당 문항은 최대 2개까지 선택할 수 있어요"
    }
}
