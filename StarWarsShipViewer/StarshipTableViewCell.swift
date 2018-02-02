//
//  StarshipTableViewCell.swift
//  StarWarsShipViewer
//
//  Created by Ryan Demo on 2/1/18.
//  Copyright © 2018 Ryan Demo. All rights reserved.
//

import UIKit

class StarshipTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code, like programmatically setting the background color of the cell
    }

    // Let the view update given a "view model", or some object that contains more or less formatted data for each field in the view
    func configure(for starship: Starship) {
        textLabel?.text = starship.name + ": " + starship.model
        detailTextLabel?.text = starship.costInCredits
    }

}
