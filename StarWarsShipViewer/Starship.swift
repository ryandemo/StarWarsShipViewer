//
//  Starship.swift
//  StarWarsShipViewer
//
//  Created by Ryan Demo on 2/1/18.
//  Copyright © 2018 Ryan Demo. All rights reserved.
//

import UIKit

struct Starships: Codable {
    let results: [Starship]
}

struct Starship: Codable {
    
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let crew: String
    let passengers: String
    
    // Enables Swift's built in JSON encoding/decoding, along with conformance to Codable
    private enum CodingKeys: String, CodingKey {
        case costInCredits = "cost_in_credits"
        case name, model, manufacturer, length, crew, passengers
    }
    
    // Manual init if you need it. You can do a manual decoder with the Codable protocol, but it's more confusing than this.
    init?(dict: [String: Any]) {
        guard
            let name = dict["name"] as? String,
            let model = dict["model"] as? String,
            let manufacturer = dict["manufacturer"] as? String,
            let costInCredits = dict["cost_in_credits"] as? String,
            let length = dict["length"] as? String,
            let crew = dict["crew"] as? String,
            let passengers = dict["passengers"] as? String else {
                return nil
        }
        
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.costInCredits = costInCredits
        self.length = length
        self.crew = crew
        self.passengers = passengers
    }
    
}


/* Example JSON
 
 {
     "name": "Death Star",
     "model": "DS-1 Orbital Battle Station",
     "manufacturer": "Imperial Department of Military Research, Sienar Fleet Systems",
     "cost_in_credits": "1000000000000",
     "length": "120000",
     "max_atmosphering_speed": "n/a",
     "crew": "342953",
     "passengers": "843342",
     "cargo_capacity": "1000000000000",
     "consumables": "3 years",
     "hyperdrive_rating": "4.0",
     "MGLT": "10",
     "starship_class": "Deep Space Mobile Battlestation",
     "pilots": [],
     "films": [
        "https://swapi.co/api/films/1/"
     ],
     "created": "2014-12-10T16:36:50.509000Z",
     "edited": "2014-12-22T17:35:44.452589Z",
     "url": "https://swapi.co/api/starships/9/"
 }
 
 */
