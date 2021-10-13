//
//  AcronymsTests.swift
//  AcronymsTests
//
//  Created by Alok on 12/10/21.
//

import XCTest
@testable import Acronyms

class AcronymsTests: XCTestCase {
    
    private var appFactory: AppFactory!
    private var apiClient: RemoteGateway!
    private var searchVC: SearchViewController!
    
    override func setUpWithError() throws {
        
        // Create The factory
        appFactory = AppFactory()
        
        // API Client
        apiClient = RemoteGateway()
        
        // Get The SearchViewController
        searchVC = appFactory.getSearchViewController(apiClient: apiClient) as? SearchViewController
        
        // Load view
        searchVC.loadView()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    // Test Case to check max allowed limit for search bar.
    func testSearchBarMaxLimit() {
        
        // Max allowed character
        let maxAllowedCharacter = 7
        
        // Test maximum number of allowable characters
        let atTheLimitString = String(repeating: "A", count: maxAllowedCharacter)
        searchVC.searchBar.text = atTheLimitString
        let atTheLimitResult = searchVC.searchBar(searchVC.searchBar, shouldChangeTextIn: NSRange(location: 0, length: 0), replacementText: atTheLimitString)
        
        XCTAssertTrue(atTheLimitResult, "The search bar should allow \(maxAllowedCharacter) characters")
        
        // ======= Uncomment below code to check for failure scenario ========
        // ===================================================================
        
        //        let overTheLimitString = String(repeating: "A", count: maxAllowedCharacter + 1)
        //        searchVC.searchBar.text = overTheLimitString
        //        let overTheLimitResult = searchVC.searchBar(searchVC.searchBar, shouldChangeTextIn: NSRange(location: 0, length: 0), replacementText: overTheLimitString)
        //
        //        XCTAssertTrue(overTheLimitResult, "The search bar should not allow \(maxAllowedCharacter+1) characters")
    }
    
    
    
    //=============================================================================================================
    // Test case to check special character in search bar
    // Search bar only accepts alphanumeric character's no special characters are allowed
    
    func testSpecialCharacterSearchbar() {
        
        // Test maximum number of allowable characters
        let text = "ABC"
        
        // ========== For failure case scenario please uncomment below line
        // ================================================================
        //let specialCharacter = "@#"
        let specialCharacter = "hm1"
        
        
        searchVC.searchBar.text = text
        let allowedText = searchVC.searchBar(searchVC.searchBar, shouldChangeTextIn: NSRange(location: 0, length: 0), replacementText: specialCharacter)
        
        XCTAssertTrue(allowedText, "The search bar should not allow \(specialCharacter) special characters")
        
    }
    
    //====================================================================================================
    // Test Search service call asynchronously
    // Expectation to be used for search API testing
    
    func testSearchAPI() {
        
        // Create search gateway
        let searchAPIGateway: SearchService = SearchServiceGateway(apiClient: apiClient)
        
        // Setup expectation
        let exp = expectation(description: "Search gateway execute async task and call success on completion")
        
        // Execute search task
        searchAPIGateway.search(text: "HMM") { (result) in
           
            XCTAssertNotNil(result)
            
            // Make sure to complete the process
            exp.fulfill()
        }
        
        // Wait for expectation
        let timeOut = 5.0
        //let timeOut = 0.4  // Error case scenario
        
        waitForExpectations(timeout: timeOut) { (error) in
            if let error = error {
                XCTFail("Wait for expectation with timeout errored \(error) ")
            }
        }
    }
    
}
