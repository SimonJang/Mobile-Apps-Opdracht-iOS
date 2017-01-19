//
//  RestService.swift
//  springkasteelapp

// Code gebaseerd op 
//      https://devdactic.com/parse-json-with-swift/
//      https://github.com/Alamofire/Alamofire voorbeelden
//      https://github.com/SwiftyJSON/SwiftyJSON voorbeelden
//  Deze klasse haalt de data op van de REST service
// TODO implementeren asap maar eerst CocoaPods configureren

import SwiftyJSON
import Alamofire

import Foundation
class RestService: NSObject {
    
    static let sharedInstance = RestService()
    
    // GET Request voor alle winkels (inclusief aantal springkastelen)
    // Haalt alle informatie van elke winkel op.
    // Zie Winkelobject klasse voor attributen die worden opgevraagd
    
    static func getWinkels() -> [Int:WinkelObject]? {
        
        var returnDict:[Int:WinkelObject] = [:]
        
        let json = JSON(Alamofire.request("https://x.herokuapp.com/winkels"))
        for (_, object) in json {
            let winkel = WinkelObject(object)
            returnDict[Int(winkel.storeID)!] = winkel
        }
        
        return returnDict
    }
    
    static func getSpringkastelenForDate(winkelId: Int, datum:Date) -> [Springkasteel: Int]? {
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

class WinkelObject {
    var naam: String
    var adres: String
    var telefoonnummer: String
    var storeID: String
    var JUNGLE: Int
    var PIRAAT: Int
    var CIRCUS: Int
    var JUMP: Int
    
    required init(_ json: JSON) {
        naam = json["naam"].stringValue
        adres = json["adres"].stringValue
        telefoonnummer = json["telefoonnummer"].stringValue
        storeID = json["storeID"].stringValue
        JUNGLE = json["JUNGLE"].intValue
        PIRAAT = json["PIRAAT"].intValue
        CIRCUS = json["CIRCUS"].intValue
        JUMP = json["JUMP"].intValue
    }
}
