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
        data = ReservationManager.reservaties
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCel", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Datum reservatie: \(data[indexPath.section].datum)"
        }
        else if indexPath.row == 1  {
            cell.textLabel?.text = "Contactgegevens: \(data[indexPath.section].klantEmail)"
        }
        else if indexPath.row == 2 {
            cell.textLabel?.text = "Te betalen: \(String(describing: data[indexPath.section].prijs)) €"
        }
        else if indexPath.row == 3 {
            cell.textLabel?.text = "Type springkasteel: \(data[indexPath.section].springkasteel.capitalized)"
        }
        else if indexPath.row == 4 {
            cell.textLabel?.text = "Afhaalpunt: \(data[indexPath.section].store)"
        }
        else if indexPath.row == 5 {
            cell.textLabel?.text = "Duur huur: \(String(describing: data[indexPath.section].termijn)) dagen"
        }
        /*
         
         Werkende basic code
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCel", for: indexPath)
        
        cell.textLabel?.text = "Test Reservatie 
        */
        
        return cell
    }
    

}
