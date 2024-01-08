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
        }
    }
    
    enum myPage {
        static var point = "보유 포인트"
        static var badge = "배지 컬랙션"
        
        static var journey = "지금까지의 여정"
        static var store = "상점"
        
        static var TOS = "이용약관"
        static var privacyPolicy = "개인정보처리방침"
        
        static var logout = "로그아웃"
        static var quit = "회원탈퇴"
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
}
