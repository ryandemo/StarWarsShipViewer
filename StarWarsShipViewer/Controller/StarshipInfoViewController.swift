//
//  StarshipInfoViewController.swift
//  StarWarsShipViewer
//
//  Created by Ryan Demo on 4/23/19.
//  Copyright © 2019 Ryan Demo. All rights reserved.
//

import UIKit

class StarshipInfoViewController: UIViewController {
    
    var starship: Starship?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func updateLabel(_ sender: Any) {
        nameLabel.text = starship?.name ?? "Can't get name"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
