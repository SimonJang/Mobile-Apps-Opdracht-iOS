
// Detail van de SplitView
// de informatie (in String) is hardcoded in deze controller
// Bevat de (beperkte) logica voor het tonen van de informatie
// De extension onderaan is overgenomen van een suggestie in StackOverflow

import UIKit

class HuurDetailSplitViewController: UIViewController {
    
    private var praktisch:Bool = false
    private var voorwaarden: Bool = true // Default waarde wanneer de app wordt opgestart
    
    var praktischValue:Bool {
        get {
            return praktisch
        }
        set(value) {
            praktisch = value
            voorwaarden = !value
        }
    }
    
    var voorwaardenValue:Bool {
        get {
            return voorwaarden
        }
        set(value) {
            praktisch = !value
            voorwaarden = value
        }
    }
    
    @IBOutlet weak var headerTxt: UILabel!
    
    @IBOutlet weak var mainTxt: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillOutlets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillOutlets()
    }
    
    private func fillOutlets() {
        if praktischValue {
            let formattedString = NSMutableAttributedString()
            formattedString
                .bold("Compact te vervoeren\n")
                .normal("Je haalt het springkasteel zelf op in de DreamLand-winkel in jouw buurt (geen thuislevering mogelijk). De afmetingen van het pakket zijn: L 120 x B 90 x H 60 cm. Het pakket kan normaal gezien door 2 personen gedragen worden, en je kan het vervoeren in een auto van gemiddelde grootte.\n")
                .bold("Alle instructies bij de hand\n")
                .normal("Als je je springkasteel afhaalt, krijg je van ons een informatieblad met alle info die je nodig hebt om je springkasteel te installeren of op te ruimen.\n")
                .bold("Installeren geblazen\n")
                .normal("Plooi het springkasteel open en blaas het op door de blazer (50 x 50 x 20 cm, gewicht = 5 kg) in het stopcontact te steken. En 5 minuten later staat je springkasteel recht!\n")
                .bold("Opruimen in een oogwenk\n")
                .normal("Plooi het springkasteel droog op tot een klein pakket. Opplooien doe je van buiten naar binnen.").endEditing()
            
            headerTxt.text = "Praktisch"
            mainTxt.attributedText = formattedString
        }
        else {
            let formattedString = NSMutableAttributedString()
            formattedString
                .bold("Legale Informatie\n")
                .normal("Dreamland kan niet aansprakelijk worden gesteld voor gebeurlijke ongevallen")
                .endEditing()
            headerTxt.text = "Voorwaarden"
            mainTxt.attributedText = formattedString
        }
    }
}

// Source: http://stackoverflow.com/questions/28496093/making-text-bold-using-attributed-string-in-swift
// Code overgenomen enkel letertype aangepast
// Ik wil verschillende subsecties maken in de UITextView maar niet hardcoded in het storyboard
// Werking lijkt vergelijkbaar met StringBuilder in Java

extension NSMutableAttributedString {
    func bold(_ text:String) -> NSMutableAttributedString {
        let attrs:[String:AnyObject] = [NSFontAttributeName : UIFont(name: "HelveticaNeue-Bold", size: 16)!]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}
