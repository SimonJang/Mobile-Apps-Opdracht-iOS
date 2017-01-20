//
//  ReserveerViewController.swift
//  dlspringkasteelapp
//
//  Created by Simon Jang on 20/01/17.
//  Copyright © 2017 Simon Jang. All rights reserved.
//

import UIKit

class ReserveerViewController: UIViewController {
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var winkelLabel: UILabel!
    @IBOutlet weak var datumLabel: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var warningEmptyMail: UILabel!
    
    var springkasteel:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        fillOutlets()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fillOutlets() {
        titelLabel.text = "Reservatie \(springkasteel)"
        winkelLabel.text = "Gereserveerd in \(ReservationManager.geselecteerdeWinkel!.storeName)"
        
        if let datum = ReservationManager.geselecteerdeDatum {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            let stringDate = dateFormatter.string(from: datum)
            datumLabel.text = "Gereserveerd op \(stringDate)"
        }
        
    }
    
    // Gebruik van regex voor validatie
    // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        switch(identifier) {
            case "toonBevestiging":
                if let input = emailTxt.text {
                    if !emailTest.evaluate(with: input) {
                        return false
                    }
                    else {
                        ReservationManager.emailKlant = input
                        return true
                    }
                }
            default:
                return true
        }
        return false
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toonBevestiging", let _ = segue.destination as? BevestigingViewController {
            // TODO imlementeren indien nodig
        }
    }
 

}
