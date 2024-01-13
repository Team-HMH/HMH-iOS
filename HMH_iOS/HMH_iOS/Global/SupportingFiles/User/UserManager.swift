//
//  UserManager.swift
//  HMH_iOS
//
//  Created by Seonwoo Kim on 1/12/24.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    
    @UserDefaultWrapper<String>(key: "accessToken") private(set) var accessToken
    @UserDefaultWrapper<String>(key: "refreshToken") private(set) var refreshToken
    @UserDefaultWrapper<String>(key: "AppleToken") private(set) var appleToken
    @UserDefaultWrapper<String>(key: "userIdentifier") private(set) var appleUserIdentifier
    @UserDefaultWrapper<String>(key: "familyName") private(set) var familyName
    @UserDefaultWrapper<String>(key: "givenName") private(set) var givenName
    @UserDefaultWrapper<String>(key: "fullName") private(set) var fullName
    @UserDefaultWrapper<Int>(key: "userId") private(set) var userId
    
    var hasAccessToken: Bool { return self.accessToken != nil }
    var getAccessToken: String { return self.accessToken ?? "" }
    var getRefreshToken: String { return self.refreshToken ?? "" }
    var getAppleToken: String { return self.appleToken ?? "" }
    var getUserIdentifier: String { return self.appleUserIdentifier ?? "" }
    var getUserName: String { return self.familyName ?? "" }
    var getGivenName: String { return self.givenName ?? "" }
    var getFullName: String { return self.fullName ?? "" }
    var getUserId: Int { return self.userId ?? 0}
    
    var haveFullName: Bool {
        if fullName == "" {
            return false
        } else if fullName == nil {
            return false
        } else {
            return true
        }
    }
    
    private init() {}
}

extension UserManager {
    func updateToken(_ accessToken: String, _ refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func updateAppleToken(_ appleToken: String) {
        self.appleToken = appleToken
    }
    
    func updateUserIdentifier(_ appleUserIdentifier: String) {
        self.appleUserIdentifier = appleUserIdentifier
    }
    
    func updateUserName(_ givenName: String, _ familyName: String) {
        self.givenName = givenName
        self.familyName = familyName
        self.fullName = familyName + givenName
    }
    
    func updateUserId(_ userId: Int) {
        self.userId = userId
    }
    
    func setUserIdForApple(userId: String) {
        self.appleUserIdentifier = appleUserIdentifier
    }
    
    func clearAll() {
        self.accessToken = nil
        self.refreshToken = nil
        self.appleToken = nil
        self.appleUserIdentifier = nil
        self.familyName = nil
        self.givenName = nil
        self.fullName = nil
        self.userId = nil
    }
    
    func clearData() {
        self.accessToken = nil
        self.refreshToken = nil
        self.appleToken = nil
        self.appleUserIdentifier = nil
    }
}
