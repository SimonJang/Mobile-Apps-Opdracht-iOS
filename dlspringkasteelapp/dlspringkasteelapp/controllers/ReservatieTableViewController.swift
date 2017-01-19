//
//  ReservatieTableViewController.swift
//  dlspringkasteelapp
//
//  Voor code gebaseerd op https://www.ralfebert.de/tutorials/ios-swift-uitableviewcontroller/
//  Geen copy/paste maar als voorbeeld van hoe table view moet worden geïmplementeerd
//

import UIKit

class ReservatieTableViewController: UITableViewController {
    
    var user:String = ""
    var data:[Reservatie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maakGebruiker(ReservationManager.huidigeGebruiker)
        data = ReservationManager.haalReservatieOpVoorKlantMetEmail(user)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    public func maakGebruiker(_ naam:String) {
        user = naam;
        print(naam)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
        var cell = UITableViewCell()
        cell.textLabel?.text = "test"
        return cell
    }

}
