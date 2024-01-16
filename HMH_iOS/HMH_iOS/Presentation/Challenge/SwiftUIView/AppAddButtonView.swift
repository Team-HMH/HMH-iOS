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

//class AppAddButtonViewModel: ObservableObject {
//    @Published var newSerlection: FamilyActivitySelection
//
//    init(newSelection: FamilyActivitySelection) {
//        self.newSelection = newSelection
//    }
//}

struct AppAddButtonView: View {
    
    @EnvironmentObject var model: BlockingApplicationModel
  //  var appTokens: [String]
    var appGroupData: [String] = []
    let userDefaults = UserDefaults(suiteName: "group.HMH")
    @AppStorage("appTitle") var appTitle: String = ""
    @State var isPresented = false
    
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
                if let applicationToken = model.newSelection
                    .applicationTokens.first {
                    let label = Label(applicationToken)
                }
                if newValue == false {
                    
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
    
    func storeMonitor() {
        
    }
}

#Preview {
    AppAddButtonView()
        .environmentObject(BlockingApplicationModel.shared)
}
