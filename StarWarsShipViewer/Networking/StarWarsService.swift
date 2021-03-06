//
//  StarWarsService.swift
//  StarWarsShipViewer
//
//  Created by Ryan Demo on 2/1/18.
//  Copyright © 2018 Ryan Demo. All rights reserved.
//

import Foundation

/// Defines errors thrown by the StarWarsService. Represent your errors as enum cases, and make them conform to the Error protocol.
enum StarWarsServiceError: Error {
    case dataNotFound
}

struct StarWarsService {
    
    func getStarships(completion: @escaping (Result<[Starship], Error>) -> Void) {
        
        let route = URL(string: "https://swapi.co/api/starships")!
        
        // Create a request. Properties of the request, like request.httpMethod and request.httpBody, allow you to do any type of HTTP request.
        let request = URLRequest(url: route)
        
        // Create a URL session data task with the request, and give code to execute upon response.
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {  // If there was an error, pass it back to the getStarships caller
                completion(.failure(error))
                
            } else if let data = data {  // If the data exists
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let starships = try decoder.decode(Starships.self, from: data)
                    completion(.success(starships.results))
                    
                } catch {  // This will catch JSON decoder errors
                    completion(.failure(error))
                }
                
            } else {  // If we're here, the data doesn't exist and we can return our custom error
                completion(.failure(StarWarsServiceError.dataNotFound))
            }
        }
        
        // Start the request. Can also use task.cancel() after the fact.
        task.resume()
        
    }
    
}
