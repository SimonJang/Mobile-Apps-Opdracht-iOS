// Wanneer er geen/slechte internet verbinden is en de spinner leeg is, is het niet mogelijk om te seguen naar volgende scherm
// Reden? Anders een exception op Optional omdat er geen winkel is geselecteerd (geselecteerdeWinkel = nil)
// en force unwrapping doet de app crashen
// Het selecteren van een winkel is redelijk cruciaal

import UIKit

class WinkelSelectorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, DataModelWinkelDelegate {

    var winkels:[Int:Winkel] = [:]
    private let dataModelWinkel = DataModelWinkel()
    
    @IBOutlet weak var winkelPicker: UIPickerView!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if winkelPicker.numberOfRows(inComponent: 0) == 0 {
            return false
        }
        else {
            return true
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dataModelWinkel.delegate = self
        dataModelWinkel.requestWinkels()
        
        winkelPicker.delegate = self
        winkelPicker.dataSource = self
    }
    
    func vraagWinkels(data: [WinkelObject]) {
        self.winkels = UtilityServices.utilServices.convertWinkelObjectToWinkelDict(input: data)
        self.winkelPicker.reloadAllComponents()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataModelWinkel.requestWinkels()

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
            return "Werkt niet"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let keys = Array(winkels.keys)
        if let winkel = winkels[keys[row]] {
            ReservationManager.geselecteerdeWinkel = winkel
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "naarDatumSelector" {
            let keys = Array(winkels.keys)
            let row = winkelPicker.selectedRow(inComponent: 0)
            if let winkel = winkels[keys[row]] {
                ReservationManager.geselecteerdeWinkel = winkel
            }
        }
    }
 

}
