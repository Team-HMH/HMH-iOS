//
//  BlockingApplicationModel.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/4/24.
//

import SwiftUI
import FamilyControls
import ShiledConfig
import ManagedSettings

final class BlockingApplicationModel: ObservableObject {
    static let shared = BlockingApplicationModel()
    @Published var newSelection: FamilyActivitySelection = .init()
    @AppStorage("bundle", store: UserDefaults(suiteName: "group.HMH"))
    var appBundleId = ""
    
    @Published private(set) var appList: [String] = []
    var onModelUpdate: (() -> Void)?
    
    private func updateAppList() {
        onModelUpdate?()
    }
    
    init() {
        updateAppList()
        print(appList)
    }
    
    var selectedAppsTokens: Set<ApplicationToken> {
        newSelection.applicationTokens
    }
    
    var selectedApps: [ApplicationToken: String] {
        var appsDictionary: [ApplicationToken: String] = [:]
        
        for token in selectedAppsTokens {
            let localizedDisplayName = localizedDisplayNameForToken(token)
            appsDictionary[token] = localizedDisplayName
            print(appBundleId)
        }
        
        return appsDictionary
    }
    
    private func localizedDisplayNameForToken(_ token: ApplicationToken) -> String {
        return ""
    }
    
}
