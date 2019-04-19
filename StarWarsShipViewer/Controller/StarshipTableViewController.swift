//
//  StarshipTableViewController.swift
//  StarWarsShipViewer
//
//  Created by Ryan Demo on 2/1/18.
//  Copyright © 2018 Ryan Demo. All rights reserved.
//

import UIKit

class StarshipTableViewController: UITableViewController {
    
    let service = StarWarsService()
    var starships = [Starship]()

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadStarships()
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        reloadStarships()
    }

    func reloadStarships() {
        service.getStarships { result in

            // Must call this UI-updating code on the UI thread
            DispatchQueue.main.async {
                switch result {
                case .success(let starships):
                    self.starships = starships
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    self.presentAlert(withMessage: error.localizedDescription)
                }
            }
        }
    }
    
    func presentAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // this code is executed when the alert button is tapped
            print("OK button tapped, message: \(message)")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starships.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starshipCell", for: indexPath) as! StarshipTableViewCell
        
        let starship = starships[indexPath.row]
        cell.configure(for: starship)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Deselect right after select to get the "cell was just tapped once" animation
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let rowTapped = indexPath.row
        let starship = starships[rowTapped]
        
        // Sender is an arbitrary object you can send to the segue handler below.
        self.performSegue(withIdentifier: "ShowInfo", sender: starship)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
