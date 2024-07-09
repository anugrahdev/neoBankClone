//
//  SceneDelegate.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let initialViewController = LandingPageRouter.assembleModule()
        
        let navigationController = UINavigationController(rootViewController: initialViewController)
        
        let imgBack = UIImage.init(systemName: "chevron.backward")
        
        navigationController.navigationBar.backIndicatorImage = imgBack
        navigationController.navigationBar.backIndicatorTransitionMaskImage = imgBack
        navigationController.navigationItem.leftItemsSupplementBackButton = true
        navigationController.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController.navigationBar.tintColor = .black
        UILabel.appearance().font = UIFont.appFont(ofSize: UIFont.labelFontSize)

        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
