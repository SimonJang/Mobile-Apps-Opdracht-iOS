
// Bevat de segues naar detail view
// Is de master voor de UISplitView

import UIKit

class VoorwaardenViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

