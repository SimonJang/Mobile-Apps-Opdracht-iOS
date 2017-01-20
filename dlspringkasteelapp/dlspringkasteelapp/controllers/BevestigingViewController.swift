//
//  BevestigingViewController.swift
//  dlspringkasteelapp


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
