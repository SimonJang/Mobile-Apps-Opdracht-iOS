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
            return springkasteel
        }
    }

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
                    if UtilityServices.utilServices.validateEmail(email: input) {
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
