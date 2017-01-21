
//  ReserveerViewController.swift

import UIKit

class ReserveerViewController: UIViewController, DataModelRegistreerReservatieDelegate {
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var winkelLabel: UILabel!
    @IBOutlet weak var datumLabel: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var warningEmptyMail: UILabel!
    
    private let dataModelReserveren = DataModelRegistreerReservatie()
    var springkasteel:String = ""
    
    var stelSpringKasteelIn:String {
        set(geselecteerdSpringKasteel) {
            if !(geselecteerdSpringKasteel == "jump") {
                springkasteel = geselecteerdSpringKasteel
            }
            else {
                springkasteel = "Jump 'o Line"
            }
        }
        get {
            if springkasteel == "Jump 'o Line" {
                return "jump"
            }
            return springkasteel
        }
    }
    
    func reservatieVoltooid() {
        self.performSegue(withIdentifier: "toonBevestiging", sender: "Registratie voltooid")
    }
    
    func reservatieFailure() {
        warningEmptyMail.isHidden = false;
        warningEmptyMail.text = "Reservatie mislukt. Probeer opnieuw"
        emailTxt.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataModelReserveren.delegate = self
        fillOutlets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fillOutlets() {
        titelLabel.text = "Reservatie \(springkasteel.capitalized)"
        winkelLabel.text = "Gereserveerd in \(ReservationManager.geselecteerdeWinkel!.storeName)"
        
        if let datum = ReservationManager.geselecteerdeDatum {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let stringDate = dateFormatter.string(from: datum)
            datumLabel.text = "Gereserveerd op \(stringDate)"
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        switch(identifier) {
            case "toonBevestiging":
                if let input = emailTxt.text {
                    if !UtilityServices.utilServices.validateEmail(email: input) {
                        warningEmptyMail.isHidden = false
                        warningEmptyMail.text = "Ongelding email adres"
                        emailTxt.text = ""
                        return false
                    }
                    else {
                        ReservationManager.emailKlant = input
                        let stringDate = UtilityServices.utilServices.convertDatumNaarString(datum: ReservationManager.geselecteerdeDatum!)
                        
                        let nieuweReservatie = Reservatie(klant: input,
                                                    gewenstSpringkasteel: stelSpringKasteelIn,
                                                    datum: stringDate,
                                                    afhaalwinkel: String(ReservationManager.geselecteerdeWinkelMetAangepasteSpringkastelen!.storeId),
                                                    termijn: 1)
                        dataModelReserveren.registreer(reservatie: nieuweReservatie)
                        return false
                    }
                }
            default:
                reservatieFailure()
                return false
        }
        return false
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toonBevestiging", let _ = segue.destination as? BevestigingViewController {
            // Niet nodig?
        }
    }
 

}
