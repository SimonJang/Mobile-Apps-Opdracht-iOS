//
//  Store.swift
//  springkasteelapp
//
// Attributen van de winkel
// Wordt opgevraagd om een lijst te bezorgen met alle winkels

// Misschien als extra nog adres voorzien en telefoonnummer?

import Foundation
class Winkel {
    var storeId: Int;
    var storeName: String;
    var adresWinkel: String = ""
    var telefoonNummerWinkel: String = ""
    
    init(storeID: Int, storeNAME: String) {
        self.storeId = storeID;
        self.storeName = storeNAME;
    }
}
