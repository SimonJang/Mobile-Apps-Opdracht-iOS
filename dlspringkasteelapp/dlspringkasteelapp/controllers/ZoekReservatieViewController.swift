//
//  ZoekReservatieViewController.swift
//  dlspringkasteelapp
//
//  Created by Simon Jang on 19/01/17.
//  Copyright © 2017 Simon Jang. All rights reserved.
//

import UIKit

class ZoekReservatieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ZoekReservatie" {
            let destination = segue.destination as? ReservatieTableViewController
            if let input = emailTxt?.text {
                ReservationManager.huidigeGebruiker = input
            }
        }
    }
 

}
