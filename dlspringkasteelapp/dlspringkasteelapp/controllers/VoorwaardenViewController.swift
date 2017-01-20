//
//  VoorwaardenViewController.swift
//  dlspringkasteelapp

// Bevat de segues naar detail view

import UIKit

class VoorwaardenViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch(identifier) {
                case "showPraktisch":
                    if let destination = segue.destination as? HuurDetailSplitViewController {
                        destination.praktischValue = true
                    }
                case "showVoorwaarden":
                    if let destination = segue.destination as? HuurDetailSplitViewController {
                       destination.voorwaardenValue = true
                    }
                default:
                break
            }
        }
    }
}



// Backup code voor segue oplossing
// Werkt dan op iphone maar niet op ipad
