//
//  BlockingApplicationModel.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/4/24.
//

import Foundation
import FamilyControls
import ManagedSettings

final class BlockingApplicationModel: ObservableObject {
    static let shared = BlockingApplicationModel()
    
    @Published var newSelection: FamilyActivitySelection = .init() {
        didSet {
            updateAppList()
        }
    }
    
    @Published private(set) var appList: [String] = []
    var onModelUpdate: (() -> Void)?
    
    private func updateAppList() {
        appList = selectedApps.compactMap { $0.localizedDisplayName }
        onModelUpdate?()
    }
    
    init() {
        updateAppList()
    }
    
    var selectedAppsTokens: Set<ApplicationToken> {
        newSelection.applicationTokens
    }
    
    var selectedApps: Set<Application> {
        newSelection.applications
    }
    
}
