//
//  RestService.swift
//  springkasteelapp

// Code gebaseerd op 
//      https://devdactic.com/parse-json-with-swift/
//      https://github.com/Alamofire/Alamofire voorbeelden
//      https://developer.apple.com/swift/blog/?id=37 laatste voorbeeld
//  Deze klasse haalt de data op van de REST service
// TODO implementeren asap maar eerst CocoaPods configureren

import SwiftyJSON

import Foundation
class RestService: NSObject {
    
    static let sharedInstance = RestService()
    let baseUrl = "https://x.herokuapp.com/"
    
    // GET Request voor alle winkels (inclusief aantal springkastelen
    
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
