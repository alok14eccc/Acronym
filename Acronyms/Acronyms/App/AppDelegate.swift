//
//  AppDelegate.swift
//  Acronyms
//
//  Created by Alok on 12/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        setupAppInitials()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    //MARK:- Private Methods
    private func setupAppInitials() {
        let appFactory = AppFactory()
        let apiClient = RemoteGateway()
        let appNavigator = AppViewNavigator(window: window!, factory: appFactory, client: apiClient)
        appNavigator.to(.welcomeScreen)
    }
    
}

