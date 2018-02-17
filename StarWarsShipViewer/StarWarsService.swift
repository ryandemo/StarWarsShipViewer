//
//  StarWarsService.swift
//  StarWarsShipViewer
//
//  Created by Ryan Demo on 2/1/18.
//  Copyright © 2018 Ryan Demo. All rights reserved.
//

import Foundation

/// Simple struct to hold your API endpoints. Having a baseURL init lets you quickly swap between dev and production, localhost vs AWS, etc.
struct API {
    static let prodBase = URL(string: "https://swapi.co/api/")!  // Use ! after this to "force unwrap" the optional because you know for sure that it's a URL string.
    
    let starships: URL
    
    init(baseURL: URL) {
        starships = baseURL.appendingPathComponent("starships")
    }
}

// Simple generic enum with associated values that takes advantage of the Swift language
enum Result<Value> {
    case success(Value)
    case failure(Error)
}

/// Defines errors thrown by the StarWarsService. Represent your errors as enum cases, and make them conform to the Error protocol.
enum StarWarsServiceError: Error {
    case dataNotFound
}

struct StarWarsService {
    
    let api = API(baseURL: API.prodBase)
    
    // Uncomment these lines to make a singleton accessible from anywhere in the app and force its use.
    // Use a singleton and look up Alamofire's RequestAdapter if you want to, for example, add an auth token to the header of every request.
    // static let shared = StarWarsService()
    // private init() { }
    
    func getStarships(completion: @escaping (Result<[Starship]>) -> Void) {
        
        // Create a request. Properties of the request, like request.httpMethod and request.httpBody, allow you to do any type of HTTP request.
        let request = URLRequest(url: api.starships)
        
        // Create a URL session data task with the request, and give code to execute upon response.
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Code that will be executed when you get a response back from your request
            
            if let error = error {  // If there was an error, pass it back to the getStarships caller
                completion(.failure(error))
                
            } else if let data = data {  // If the data exists
                do {
                    // If there's any dates in your model, you can customize how the date is decoded like so:
                    // let formatter = DateFormatter()
                    // formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                    // let d = JSONDecoder()
                    // d.dateDecodingStrategy = .formatted(formatter)
                    // let starships = try d.decode(Starships.self, from: data)
                    
                    let starships = try JSONDecoder().decode(Starships.self, from: data)
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
