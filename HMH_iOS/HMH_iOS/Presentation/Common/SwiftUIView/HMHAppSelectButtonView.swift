//
//  HMHAppSelectButtonView.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/4/24.
//

import SwiftUI
import UIKit
import FamilyControls

struct HMHAppSelectButtonView: View {
    
    @EnvironmentObject var model: BlockingApplicationModel
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            Color(uiColor: .clear)
            RoundedRectangle(cornerRadius: 6)
                .fill(Color(red: 0.24, green: 0.09, blue: 0.83))
            Button(action: { isPresented.toggle() }) {
                Text("앱 선택하기")
                    .font(Font.custom("Pretendard-SemiBold", size: 16.adjusted))
                    .foregroundColor(.white)
                    .frame(width: 336, height: 52)
                    .background(Color(uiColor: .bluePurpleButton))
            }
            .familyActivityPicker(isPresented: $isPresented, selection: $model.newSelection)
            .onChange(of: isPresented) { oldValue, newValue in
                if !isPresented {
                    let appTokens: () = model.selectedAppsTokens.forEach {
                        print($0)
                    }
                    let mainViewController = AppSelectViewController()
                    let navigationController = UINavigationController(rootViewController: mainViewController)
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                    guard let delegate = sceneDelegate else {
                        return
                    }
                    delegate.window?.rootViewController = navigationController
                    navigationController.pushViewController(OnboardingGoalTimeViewController(), animated: true)
                }
            }
        }
    }
    
}

#Preview {
    HMHAppSelectButtonView()
}

