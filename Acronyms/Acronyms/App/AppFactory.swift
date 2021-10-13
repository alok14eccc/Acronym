//
//  AppFactory.swift
//  Acronyms
//
//  Created by Alok on 12/10/21.
//

import Foundation
import UIKit

// Class use to instantiate app level screen
final class AppFactory {
    
    func getWellcomeViewController(appNavigator: AppNavigator) -> UIViewController {
        
        // Instantiate View Model
        let vm = WellcomeViewModel(appNavigator: appNavigator)
        
        // Instantiate View Controller
        let vc = UIStoryboard(name: "WellcomeViewController", bundle: nil).instantiateInitialViewController() as? WellcomeViewController
        
        // Inject view model to VC
        vc?.inject(vm)
        return vc!
        
    }
    
    func getSearchViewController(apiClient: ApiClient) -> UIViewController {
        
        // Instantiate view model
        let vm = SearchViewModel(service: SearchServiceGateway(apiClient: apiClient))
        
        // Instantiate View Controller
        let vc = UIStoryboard(name: "SearchViewController", bundle: nil).instantiateInitialViewController() as! SearchViewController
        
        // Setting the delegate
        vm.delegate = vc
        
        // Adding dependency
        vc.inject(model: vm)
        
        return vc
        
    }
    
}
