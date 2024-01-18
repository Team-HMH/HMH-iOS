//
//  BlockingApplicationModel.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/4/24.
//

import SwiftUI
import FamilyControls
import ManagedSettings

final class BlockingApplicationModel: ObservableObject {
    static let shared = BlockingApplicationModel()
    @Published var newSelection: FamilyActivitySelection = .init()
    @AppStorage("bundle", store: UserDefaults(suiteName: "group.65NSM72327.HMH-iOS.HMH-iOS"))
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
}
