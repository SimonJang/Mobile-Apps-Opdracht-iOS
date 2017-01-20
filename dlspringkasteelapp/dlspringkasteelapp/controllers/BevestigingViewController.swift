//
//  BevestigingViewController.swift
//  dlspringkasteelapp
//
//  Created by Simon Jang on 20/01/17.
//  Copyright © 2017 Simon Jang. All rights reserved.
//

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
