//
//  Klant.swift
//  springkasteelapp

// Informatie van de klant
// Dit is enkel voor de reservatie. Een gebruiker moet geen account maken om een springkasteel te reserveren

import Foundation
struct Klant {
    var firstName: String
    var lastName: String
    var idNumber: String
    var email: String
    
    init(f_name: String, l_name: String, id_number:String, klantEmail: String ){
        self.firstName = f_name
        self.lastName = l_name
        self.idNumber = id_number
        self.email = klantEmail
    }
}
