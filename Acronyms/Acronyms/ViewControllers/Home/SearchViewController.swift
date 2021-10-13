//
//  SearchViewController.swift
//  Acronyms
//
//  Created by Alok on 12/10/21.
//

import UIKit

class SearchViewController: UIViewController, AlertsPresenter {
    
    // Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Private Properties
    private var viewModel: SearchViewModel?
    private var listData: [AcronymDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make sure to hide unwanted table cells
        tableView.tableFooterView = UIView()
        
        // Make sure done button of search bar should not in enable state initially
        searchBar.enablesReturnKeyAutomatically = true
    }
    
    //MARK:- Public Method
    func inject(model: SearchViewModel) {
        self.viewModel = model
    }
    
    
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return row count
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get The cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        
        // Set the value
        cell.textLabel?.text = listData[indexPath.row].lf
        
        return cell
    }
}


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // Set the value of search string to view model
        viewModel?.searchText = searchText
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Make Sure search string length should not greater than 7
        if let text = searchBar.text, text.count > 7 {
            return false
        }
        
        
        // Get invalid characters, Alpha numeric is allowed
        let invalidChars = NSCharacterSet.alphanumerics.inverted
        
        // Make new string with invalid characters trimmed
        let newString = text.trimmingCharacters(in: invalidChars)
        
        if newString.count < text.count {
            return false
        } else {
            return true
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        // Show up the cancel button on search bar
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        // Hide the cancel button when key board hides
        searchBar.showsCancelButton = false
        
        // Make sure to hide key board
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Make sure to hide key board
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: searchViewProtocol {
    func populateSearchView(with data: [AcronymDetails]) {
        
        // Make sure to reload the table view
        defer {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // Set the list of data
        listData = data
    }
    
    func showError(error: ServerResponseError) {
        DispatchQueue.main.async {
            // Show alert on main thread
            self.showAlert(message: error.description)
        }
    }
}
