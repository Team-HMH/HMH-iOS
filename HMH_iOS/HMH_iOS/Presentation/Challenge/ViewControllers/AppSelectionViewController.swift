//
//  AppSelectionViewController.swift
//  HMH_iOS
//
//  Created by 지희의 MAC on 1/10/24.
//

import SwiftUI
import UIKit
import FamilyControls


struct AppSelectionViewController : UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selection: FamilyActivitySelection

    func makeUIViewController(context: Context) -> UIViewController {
        let coordinator = AppCoordinator(parent: self)
        let viewController = ChallengeViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update UI if needed
    }

    func makeCoordinator() -> AppCoordinator {
        return AppCoordinator(parent: self)
    }
    
    func saveSelectedApp(selection: FamilyActivitySelection) {
        self.selection = selection
    }
    
    class AppCoordinator: NSObject {
        var parent: AppSelectionViewController?
        
        init(parent: AppSelectionViewController) {
            self.parent = parent
        }
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
    
    
    func makeCoordinator() -> Coordinator { // <-
        Coordinator()
    }
    
    class Coordinator: NSObject { 
        
    }
}
