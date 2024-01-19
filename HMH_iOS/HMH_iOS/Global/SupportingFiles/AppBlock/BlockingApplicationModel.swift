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
