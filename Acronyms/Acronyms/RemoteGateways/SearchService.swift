//
//  SearchService.swift
//  Acronyms
//
//  Created by Alok on 13/10/21.
//

import Foundation

protocol SearchService {
    func search(text: String, completion: @escaping (Result<[AcronymDetails], ServerResponseError>)-> Void)
}

class SearchServiceGateway: SearchService {
    
    // Private variables
    private let apiClient: ApiClient
    
    // MARK:- Initialisation
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func search(text: String, completion: @escaping (Result<[AcronymDetails], ServerResponseError>) -> Void) {
        
        if let url = URL(string: SearchServiceGatewayConstants.searchURL + text) {
            apiClient.fetchFromRemote(responseModel: Acronym.self, url: url) { (result) in
                
                switch result {
                    case .success(let data):
                        guard let acronymModel = data as? [Acronym] else {
                           completion(.failure(.coding))
                            return
                        }
                        completion(.success(acronymModel.first?.lfs ?? []))
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }
    }
}

// Keep Constants
fileprivate struct SearchServiceGatewayConstants {
    static let searchURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="
}


