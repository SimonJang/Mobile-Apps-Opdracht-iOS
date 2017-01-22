// Toont bevestiging van de reservatie
// Beperkte logica (enkel back button uitschakelen van de UINavigationBar en de volledige stack poppen van de Navigation Controller
// om zo terug te keren naar de root


import UIKit

class BevestigingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func popStack(_ sender: UIButton) {
        if let controller =  self.navigationController {
            controller.popToRootViewController(animated: true)
        }
    }

}
