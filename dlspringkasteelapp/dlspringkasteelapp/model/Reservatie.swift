//
//  Reservation.swift
//  springkasteelapp
//
// Alle attributen van een reservatie

import Foundation
class Reservatie {
    var klant: Klant
    var springkasteel: Springkasteel
    var datum: Date
    var store: Winkel
    var termijn: Int
    var prijs: Double
    
    init(klant: Klant, gewenstSpringkasteel: Springkasteel, datum: Date, afhaalwinkel: Winkel, termijn: Int, teBetalen: Double) {
        self.klant = klant
        self.springkasteel = gewenstSpringkasteel
        self.datum = datum
        self.store = afhaalwinkel
        self.termijn = termijn
        self.prijs = teBetalen
    }
}
