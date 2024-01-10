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
    
    enum myPage {
        static var point = "보유 포인트"
        static var badge = "배지 컬랙션"
        
        static var journey = "지금까지의 여정"
        static var store = "상점"
        
        static var TOS = "이용약관"
        static var privacyPolicy = "개인정보처리방침"
        
        static var info = "정보"
        
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
    
    enum OnboardingButton {
        static let next = "다음"
        static let permission = "권한 허용하러 가기"
        static let selectApp = "앱 선택하기"
        static let selectComplete = "선택 완료"
        static let complete = "완료"
        static let confirm = "확인"
    }
    
    enum OnboardigMain {
        static let timeSurvey = "하루 평균 휴대폰을\n얼마나 사용하나요?"
        static let problemSurvey = "휴대폰을 사용할 때\n어떤 문제를 겪고 있나요?"
        static let selectPeriod = "챌린지 기간을 선택해 주세요"
        static let selectTotalTime = "총 목표 이용 시간을\n설정해 주세요"
        static let approvePermision = "스크린타임 권한 허용이 필요해요"
        static let appSelect = "중독에서 탈출하고 싶은\n앱을 선택해 주세요"
        static let signInComplete = "회원가입 완료"
    }
    
    enum OnboardigSub {
        static let problemSurvey = "해당 문항은 최대 2개까지 선택할 수 있어요"
        static let selectPeriod = "첫 챌린지로 가볍게 도전하기 좋은 7일을 추천해요"
        static let selectTotalTime = "목표 이용 시간은 최대 6시간까지 설정할 수 있어요"
        static let approvePermision = "언제든지 설정에서 스크린타임과 알림\n권한을 변경할 수 있어요"
        static let appSelect = "목표 이용 시간이 지나면 앱이 잠겨요\n선택하고 싶은 앱은 언제든지 추가할 수 있어요"
        static let signInComplete = "이제 하면함에서 블랙홀 탈출을 위한\n여정을 시작해 볼까요?"
    }
    
    enum TimeSurveySelect {
        static let firstSelect = "1-4시간"
        static let secondSelect = "4-8시간"
        static let thirdSelect = "8-12시간"
        static let fourthSelect = "12시간 이상"
    }
    
    enum ProblemSurveySelect {
        static let firstSelect = "일상생활에 영향을 끼쳐요"
        static let secondSelect = "이용 시간이 스스로 제어되지 않아요"
        static let thirdSelect = "특정 앱에 수시로 접속하게 돼요"
        static let fourthSelect = "중독을 탈출하려고 노력해도 잘 안 돼요"
    }
    
    enum PeriodSelect {
        static let firstSelect = "7일"
        static let secondSelect = "14일"
        static let thirdSelect = "20일"
        static let fourthSelect = "30일"
    }
}
