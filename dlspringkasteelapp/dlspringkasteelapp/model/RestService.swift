//
//  RestService.swift
//  springkasteelapp


//  Deze klasse haalt de data op van de REST service
// TODO implementeren

import Foundation
class RestService {
    static func getWinkels() -> [Int:Winkel]? {
        // TODO GET van REST-service
        return [:]
    }
    
    static func getSpringkastelen(winkelId: Int) -> [Springkasteel: Int]? {
        // TODO GET van REST-service
        return [:]
    }
    
    static func maakReservatie (reservatie: Reservatie) {
        // TODO POST naar REST-service
    }
    
    static func haalReservatieOp(idNr: Int, emailadres: String) -> Reservatie? {
        // TODO GET naar REST service voor afzonderlijke reservatie
        return nil;
    }
    
    static func haalReservatiesOp() {
        // Ophalen van datum, nog niet zeker of dat in backend gebeurt of in Swift zelf
    }
}
