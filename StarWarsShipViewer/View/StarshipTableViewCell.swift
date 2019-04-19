//
//  StarshipTableViewCell.swift
//  StarWarsShipViewer
//
//  Created by Ryan Demo on 2/1/18.
//  Copyright © 2018 Ryan Demo. All rights reserved.
//

import UIKit

class StarshipTableViewCell: UITableViewCell {
    
    @IBOutlet weak var starshipImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code, like programmatically setting the background color of the cell
    }

    // Let the view update given a "view model", or some object that contains more or less formatted data for each field in the view
    func configure(for starship: Starship) {
        starshipImageView.image = UIImage(named: starship.name) ?? UIImage(named: "placeholder.png")
        nameLabel?.text = starship.name + ": " + starship.model
        detailLabel?.text = "Cost: \(starship.costInCredits)"
    }

}
