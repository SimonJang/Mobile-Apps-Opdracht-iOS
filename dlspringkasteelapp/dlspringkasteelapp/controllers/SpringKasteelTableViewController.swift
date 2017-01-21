//  SpringKasteelTableViewController.swift

import UIKit

class SpringKasteelTableViewController: UITableViewController {
    
    var geselecteerdeWinkel = ReservationManager.geselecteerdeWinkelMetAangepasteSpringkastelen

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return geselecteerdeWinkel?.storeName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "springkasteelCel", for: indexPath) as! CustomTableViewCell

        switch(indexPath.row) {
        case 0:
            cell.backgroundColor = UIColor(red:0.56 ,green:0.72 ,blue:0.97 ,alpha:1.0)
            cell.naamLabel.text = "Naam: Jungle"
            cell.BeschikbaarLabel.text = "Aantal beschikbaar: \(String(describing: geselecteerdeWinkel!.JUNGLE))"
            cell.DimensieLabel.text = "\(cell.setDimension(x: 5.90, y: 5.60, z: 4.25))"
            return cell
        case 1:
            cell.naamLabel.text = "Naam: Piraat"
            cell.BeschikbaarLabel.text = "Aantal beschikbaar: \(String(describing: geselecteerdeWinkel!.PIRAAT))"
            cell.DimensieLabel.text = "\(cell.setDimension(x: 5.00, y: 4.50, z: 3.80))"
            return cell
        case 2:
            cell.backgroundColor = UIColor(red:0.56 ,green:0.72 ,blue:0.97 ,alpha:1.0)
            cell.naamLabel.text = "Naam: Circus"
            cell.BeschikbaarLabel.text = "Aantal beschikbaar: \(String(describing: geselecteerdeWinkel!.CIRCUS))"
            cell.DimensieLabel.text = "\(cell.setDimension(x: 6.30, y: 3.00, z: 3.60))"
            return cell
        case 3:
            cell.naamLabel.text = "Naam: Jump 'o Line"
            cell.BeschikbaarLabel.text = "Aantal beschikbaar: \(String(describing: geselecteerdeWinkel!.JUMP))"
            cell.DimensieLabel.text = "\(cell.setDimension(x: 4.10, y: 5.80, z: 3.70))"
            return cell
        default:
            return cell
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "geefKlantGegevens", let destinationVC = segue.destination as? ReserveerViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                let selectedIndex = indexPath.row
                switch(selectedIndex) {
                case 0:
                    destinationVC.springkasteel = "jungle"
                    ReservationManager.geselecteerdeSpringkasteel = Springkasteel.JUNGLE
                case 1:
                    destinationVC.springkasteel = "piraat"
                    ReservationManager.geselecteerdeSpringkasteel = Springkasteel.PIRAAT
                case 2:
                    destinationVC.springkasteel = "circus"
                    ReservationManager.geselecteerdeSpringkasteel = Springkasteel.CIRCUS
                case 3:
                    destinationVC.stelSpringKasteelIn = "jump"
                    ReservationManager.geselecteerdeSpringkasteel = Springkasteel.JUMP
                default:
                    break;
                }
            }
        }
        
    }
}
