//
//  AlertPresenter.swift
//  Acronyms
//
//  Created by Alok on 13/10/21.
//

import UIKit

protocol AlertsPresenter: UIViewController { }
extension AlertsPresenter {
    
    func showAlert(title: String = "Error", message: String) {
        
        // Create Alertcontroller
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add action to alert
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // present
        present(alert, animated: true)
    }
}
