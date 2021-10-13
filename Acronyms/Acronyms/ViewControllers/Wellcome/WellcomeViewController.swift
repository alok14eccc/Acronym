//
//  WellcomeViewController.swift
//  Acronyms
//
//  Created by Alok on 12/10/21.
//

import UIKit

class WellcomeViewController: UIViewController {
    
    private var viewModel: WellcomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // Injecting ViewModel as a dependency
    func inject(_ model: WellcomeViewModel) {
        self.viewModel = model
    }
    
    // userAction
    @IBAction func getStartedAction(_ sender: Any) {
        viewModel?.getStarted()
    }
    
}
