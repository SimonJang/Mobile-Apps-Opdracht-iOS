//
//  SpringKasteelTableViewController.swift
//  dlspringkasteelapp


import UIKit

class SpringKasteelTableViewController: UITableViewController {
    
    var geselecteerdeWinkel = ReservationManager.geselecteerdeWinkel

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return geselecteerdeWinkel?.storeName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "springkasteelCel", for: indexPath)

        switch(indexPath.row) {
        case 0:
            cell.textLabel?.text = "Beschikbare Jungle: \(String(describing: geselecteerdeWinkel!.JUNGLE))"
            return cell
        case 1:
            cell.textLabel?.text = "Beschikbare Piraat: \(String(describing: geselecteerdeWinkel!.PIRAAT))"
            return cell
        case 2:
            cell.textLabel?.text = "Beschikbare Circus: \(String(describing: geselecteerdeWinkel!.CIRCUS))"
            return cell
        case 3:
            cell.textLabel?.text = "Beschikbare Jump 'o Line: \(String(describing: geselecteerdeWinkel!.JUMP))"
            return cell
        default:
            return cell
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "geefKlantGegevens", let destinationVC = segue.destination as? ReserveerViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                let selectedIndex = indexPath.row
                destinationVC.springkasteel = "Jungle"
            }
        }
        
    }
}
