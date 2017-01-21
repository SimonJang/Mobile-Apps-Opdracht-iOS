// Controller voor opvragen van reservaties

import UIKit

class ZoekReservatieViewController: UIViewController, DataModelReservatieOpvragenKlantDelegate {
    
    private let dataModelReservatieKlant = DataModelReservatieOpvragenKlant()
    private var reservaties:[Reservatie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataModelReservatieKlant.delegate = self
        
    }
    
    func vraagReservaties(data: [Reservatie]) {
        self.reservaties = data
        if(reservaties.count > 0 ) {
            self.performSegue(withIdentifier: "ZoekReservatie", sender: "delegate")
        }
        else {
            warningTxt?.isHidden = false
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
    @IBOutlet weak var emailTxt: UITextField?
    @IBOutlet weak var warningTxt: UILabel?
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch(identifier) {
        case "ZoekReservatie":
            if let input = emailTxt?.text {
                if !UtilityServices.utilServices.validateEmail(email: input) {
                    emailTxt?.text = ""
                    warningTxt?.isHidden = false
                    return false
                }
                else if reservaties.isEmpty {
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
    
    /*
     
     // Oospronkelijke segue
     
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch(identifier) {
        case "ZoekReservatie":
            if let input = emailTxt?.text {
                if !UtilityServices.utilServices.validateEmail(email: input) {
                    return false
                    warningTxt?.isHidden = false
                }
                let reservaties = ReservationManager.haalReservatieOpVoorKlantMetEmail(input)
                if reservaties.count == 0 {
                    emailTxt!.text = ""
                    warningTxt!.isHidden = false
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
            return true
        }
        
    }
 */

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
