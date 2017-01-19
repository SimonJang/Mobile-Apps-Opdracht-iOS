//
//  WinkelSelectorViewController.swift
//  dlspringkasteelapp
//
//  Created by Simon Jang on 19/01/17.
//  Copyright © 2017 Simon Jang. All rights reserved.
//

import UIKit

class WinkelSelectorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var winkels:[Int:Winkel] = [:]
    @IBOutlet weak var winkelPicker: UIPickerView!
    
    override func viewDidLoad() {
        winkels = ReservationManager.haalWinkelsOp()
        winkelPicker.delegate = self
        winkelPicker.dataSource = self
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return winkels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let keys = Array(winkels.keys)
        if let naam = winkels[keys[row]]?.storeName {
            return naam
        }
        else {
            return "KAPUT"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let keys = Array(winkels.keys)
        if let winkel = winkels[keys[row]] {
            ReservationManager.geselecteerdeWinkel = winkel
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ReservationManager.geselecteerdeWinkel == nil {
            let keys = Array(winkels.keys)
            if let winkel = winkels[keys[0]] {
                ReservationManager.geselecteerdeWinkel = winkel
            }
        }
    }
 

}
