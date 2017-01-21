//
//  DatumSelectorViewController.swift
//  dlspringkasteelapp
//
//  Created by Simon Jang on 19/01/17.
//  Copyright © 2017 Simon Jang. All rights reserved.
//

import UIKit

class DatumSelectorViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureDatePicker() {
        let date = Date()
        let calendar = Calendar.current
        let currentYear = String(calendar.component(.year, from:date) + 1)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let maxDateString = "31-12-\(currentYear)"
        let maxDate = dateFormatter.date(from:maxDateString)
        
        datePicker.datePickerMode = .date
        datePicker.minimumDate = date
        datePicker.maximumDate = maxDate
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination
        if let identifier = segue.identifier {
            switch(identifier) {
            case "toonSpringkastelen":
                ReservationManager.geselecteerdeDatum = datePicker.date
            default:
                break
            }
        }
        
    }
}
