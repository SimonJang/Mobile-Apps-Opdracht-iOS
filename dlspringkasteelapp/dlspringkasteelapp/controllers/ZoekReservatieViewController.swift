// Controller voor opvragen van reservaties
// Bij geen connectie/geen resultaat krijgt de gebruiker een foutmelding

import UIKit

class ZoekReservatieViewController: UIViewController, DataModelReservatieOpvragenKlantDelegate {
    
    private let dataModelReservatieKlant = DataModelReservatieOpvragenKlant()
    private var reservaties:[Reservatie] = []
    
    @IBOutlet weak var warningTxt: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataModelReservatieKlant.delegate = self
        
    }
    
    func vraagReservaties(data: [Reservatie]) {
        self.reservaties = data
        if(reservaties.count > 0 ) {
            ReservationManager.reservaties = reservaties
            self.performSegue(withIdentifier: "ZoekReservatie", sender: "delegate")
        }
        else {
            warningTxt?.isHidden = false
            warningTxt?.text = "Geen reservaties gevonden"
            emailTxt?.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        warningTxt!.isHidden = true
        emailTxt!.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch(identifier) {
        case "ZoekReservatie":
            if let input = emailTxt?.text {
                if !UtilityServices.utilServices.validateEmail(email: input) {
                    emailTxt?.text = ""
                    warningTxt?.text = "Ongeldig e-mail adres!"
                    warningTxt?.isHidden = false
                    return false
                }
                else if reservaties.isEmpty {
                    dataModelReservatieKlant.requestReservatiesVoor(emailklant: input)
                    return false
                }
                else if reservaties.filter({ $0.klantEmail == input}).count == 0 {
                    dataModelReservatieKlant.requestReservatiesVoor(emailklant: input)
                    return false
                }
                else {
                    return true
                }
            }
            else {
               return false
            }
        default:
            return false
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ZoekReservatie" {
            let destination = segue.destination as? ReservatieTableViewController
            if let input = emailTxt?.text {
                destination?.user = input
                ReservationManager.huidigeGebruiker = input
            }
        }
    }
 

}
