
// Alle attributen van een reservatie

import Foundation
class Reservatie {
    var klantEmail: String
    var springkasteel: String
    var datum: String
    var store: String
    var termijn: Int
    var prijs: Double {
        get {
            return 99.00 * Double(termijn)
        }
    }
    
    init(klant: String, gewenstSpringkasteel: String, datum: String, afhaalwinkel: String, termijn: Int) {
        self.klantEmail = klant
        self.springkasteel = gewenstSpringkasteel
        self.datum = datum
        self.store = afhaalwinkel
        self.termijn = termijn
    }
}
