//
//  SearchViewModel.swift
//  Acronyms
//
//  Created by Alok on 12/10/21.
//

import Foundation

protocol searchViewProtocol: SearchViewController {
    func populateSearchView(with data: [AcronymDetails])
    func showError(error: ServerResponseError)
}

final class SearchViewModel {
    
    weak var delegate: searchViewProtocol?
    
    // Private variables
    private let searchService: SearchService
    
    // Create a searching work item
    private var searchingWorkItem: DispatchWorkItem?
    
    var searchText = "" {
        didSet {
            performSearch()
        }
    }
    
    //MARK: Initialisation
    init(service: SearchService) {
        self.searchService = service
    }
    
    func performSearch() {
        
        // Cancel the searching item
        searchingWorkItem?.cancel()
        
        // Define our searching item to do the search
        let currentWorkItem = DispatchWorkItem {
            self.searchService.search(text: self.searchText) {[weak self] (result) in
                switch result {
                    case .success(let acronyms):
                        self?.delegate?.populateSearchView(with: acronyms)
                        
                    case .failure(let error):
                        self?.delegate?.showError(error: error)
                }
            }
        }
        
        // Save the new work item and execute it after 250 ms
        searchingWorkItem = currentWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25,
                                      execute: currentWorkItem)
    }
}
 
