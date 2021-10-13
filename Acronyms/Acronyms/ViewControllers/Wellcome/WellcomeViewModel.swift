//
//  WellcomeViewModel.swift
//  Acronyms
//
//  Created by Alok on 12/10/21.
//

import Foundation

final class WellcomeViewModel {
    
    //MARK:- Properties
    private let appNavigator: AppNavigator
    
    
    //MARK:- Initialisation
    init(appNavigator: AppNavigator) {
        self.appNavigator = appNavigator
    }
    
    //MARK:- Public method
    func getStarted() {
        appNavigator.to(.home)
    }
    
}
