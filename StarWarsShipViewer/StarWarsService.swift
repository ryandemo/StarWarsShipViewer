//
//  StarWarsService.swift
//  StarWarsShipViewer
//
//  Created by Ryan Demo on 2/1/18.
//  Copyright © 2018 Ryan Demo. All rights reserved.
//

import Foundation
import Alamofire

/// Simple struct to hold your API endpoints. Having a baseURL init lets you quickly swap between dev and production, localhost vs AWS, etc.
struct API {
    let starships: URL
    
    init(baseURL: URL) {
        starships = baseURL.appendingPathComponent("starships")
    }
}

/// Defines errors thrown by the StarWarsService. Represent your errors as enum cases, and make them conform to the Error protocol.
enum StarWarsServiceError: Error {
    case dataNotFound
}

struct StarWarsService {
    
    let api = API(baseURL: URL(string: "https://swapi.co/api/")!)
    
    // Uncomment these lines to make a singleton accessible from anywhere in the app and force its use.
    // Use a singleton and look up Alamofire's RequestAdapter if you want to, for example, add an auth token to the header of every request.
    // static let shared = StarWarsService()
    // private init() { }
    
    func getStarships(completion: @escaping (_ result: Result<[Starship]>) -> Void) {
        
        Alamofire.request(api.starships, method: .get)
            .responseData { (response) in
                
                // We're guarding on the condition that the response data exists, because response.data is an optional
                guard let data = response.data else {

                    // Need to pass something to the callback whenever we exit scope
                    completion(.failure(StarWarsServiceError.dataNotFound))
                    return
                }
                
                do {
                    let starships = try JSONDecoder().decode(Starships.self, from: data)
                    completion(.success(starships.results))
                } catch {
                    completion(.failure(error))
                }
        }
        
    }
    
}
