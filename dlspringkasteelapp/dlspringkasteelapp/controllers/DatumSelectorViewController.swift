//
//  DatumSelectorViewController.swift
//  dlspringkasteelapp

import UIKit

class DatumSelectorViewController: UIViewController, DataModelBeschikbareSpringkastelenDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    private let dataModelUpdatedNotifier = DataModelBeschikbareSpringkastelen()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDatePicker()
        
        dataModelUpdatedNotifier.delegate = self
        
    }
    
    func beschikbaarheidControlerenVoltooid() {
        self.performSegue(withIdentifier: "toonSpringkastelen", sender: "checked springkastelen")
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch(identifier) {
            case "toonSpringkastelen":
                let datum = datePicker.date;
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                let stringDate = dateFormatter.string(from: datum)
                let winkelID = String(describing: ReservationManager.geselecteerdeWinkel!.storeId)
                dataModelUpdatedNotifier.beschikbaarheidVoor(datum: stringDate, inwinkel: winkelID)
                return false;
            
        default:
            return false;
        }
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
