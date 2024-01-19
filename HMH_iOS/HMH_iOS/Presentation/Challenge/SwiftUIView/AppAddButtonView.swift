//
//  AppAddButtonView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/8/24.
//

import SwiftUI
import UIKit
import FamilyControls
import DeviceActivity
import ShiledConfig

struct AppAddButtonView: View {
    let userDefaults = UserDefaults(suiteName: "group.65NSM72327.HMH-iOS.HMH-iOS")
    @AppStorage("selectedApps", store: UserDefaults(suiteName: "group.65NSM7Z327.com.HMH.group"))
        var shieldedApps = FamilyActivitySelection()
    
    @EnvironmentObject var model: BlockingApplicationModel
    @State var isPresented = false
    @StateObject var blocker = SelectedBlocker()
    
    // Used to encode codable to UserDefaults
    private let encoder = PropertyListEncoder()
    
    // Used to decode codable from UserDefaults
    private let decoder = PropertyListDecoder()
    var body: some View {
        ZStack {
            Color(uiColor: .clear)
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(uiColor: .gray8))
            Button(action: { isPresented.toggle() }) {
                Image(uiImage: ImageLiterals.Challenge.icPlus)
            }
            .frame(width: 335, height: 68)
            .familyActivityPicker(isPresented: $isPresented, selection: $model.newSelection)
            .onChange(of: isPresented)  { oldValue, newValue in
                if newValue == false {
                    ScreenTime.shared.selectedApps = model.newSelection
                    shieldedApps = model.newSelection
                    ScreenTime.shared.saveHashValue()
                    
                    let mainViewController = TabBarController()
                    let navigationController = UINavigationController(rootViewController: mainViewController)
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                    guard let delegate = sceneDelegate else {
                        return
                    }
                    delegate.window?.rootViewController = navigationController
                    navigationController.pushViewController(GoalTimeSelectViewController(), animated: true)
                }
            }
            
        }
        .background(Color(.clear))
    }
}

#Preview {
    AppAddButtonView()
        .environmentObject(BlockingApplicationModel.shared)
}
