//
//  APIClient.swift
//  Acronyms
//
//  Created by Alok on 12/10/21.
//

import Foundation

protocol ApiClient {
    func fetchFromRemote<T: Codable>(responseModel: T.Type, url: URL, completion: @escaping  (Result<Codable, ServerResponseError>)->Void)
}

// Result a generic type can have two case
enum Result<T, error:Error> {
    case success(T)
    case failure(error)
}

// Error handling scenarios
enum ServerResponseError: Error{
    case network      // Error in api call
    case coding       // Parsing issue
    
    var description: String {
        switch self {
            case .network:
                return "Some network issue occurred, Please try again."
            case .coding:
                return "Parsing issue occurred, Please try again"
        }
    }
}


// Generic class to handle API Calls and returns the specified model object
// Need to pass a URL
// Result would be return type
class RemoteGateway: ApiClient {
    
    private let session:  URLSession
    
    //MARK:- Initialisation
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    //MARK:- Public Methods
    func fetchFromRemote<T: Codable>(responseModel: T.Type, url: URL, completion: @escaping (Result<Codable, ServerResponseError>) -> Void)  {
        
        print(url)
       let task = session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            
            // Check data else return appropriate error
            guard let data = data, error == nil else {
                completion(.failure(.network))
                return
            }
            
            // Parse into specified models object else return coding error
            guard let model = try? JSONDecoder().decode([T].self, from: data) else {
                completion(.failure(.coding))
                return
            }
            
            // Successfully calling completion along with result
            completion(.success(model))
        }
        
        task.resume()
        
    }
}
