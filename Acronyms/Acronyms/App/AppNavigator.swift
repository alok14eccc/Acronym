//
//  AppNavigator.swift
//  Acronyms
//
//  Created by Alok on 12/10/21.
//

import Foundation
import UIKit

protocol AppNavigator {
    
    var window: UIWindow { get }
    func to(_ destination: AppDestination)
}

// App level screens
enum AppDestination {
    case login
    case welcomeScreen
    case home
}

// Class to handle app level screen navigation
class AppViewNavigator: AppNavigator {
    
    // MARK:- Properties
    let window: UIWindow
    private var factory: AppFactory
    private var apiClient: ApiClient
    
    // MARK:- Initialisation
    init(window: UIWindow, factory: AppFactory, client: ApiClient) {
        self.window = window
        self.factory = factory
        self.apiClient = client
    }
    
    //MARK: Public Method
    func to(_ destination: AppDestination) {
        
        switch destination {
            case .login: break
            case .welcomeScreen: show(factory.getWellcomeViewController(appNavigator: self))
            case .home: show(factory.getSearchViewController(apiClient: apiClient))
        }
    }
    
    // MARK:- Private Method
    private func show(_ viewController: UIViewController) {
        window.rootViewController = viewController
    }
}
