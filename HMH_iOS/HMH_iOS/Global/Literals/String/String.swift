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
