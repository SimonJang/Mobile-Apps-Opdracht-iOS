//
//  RestService.swift
//  springkasteelapp

// Code gebaseerd op
//      https://devdactic.com/parse-json-with-swift/
//      https://github.com/Alamofire/Alamofire voorbeelden
//      https://github.com/SwiftyJSON/SwiftyJSON voorbeelden
//      https://grokswift.com/rest-with-alamofire-swiftyjson/ voorbeelden
//
//  Deze klasse haalt de data op van een REST service



import SwiftyJSON
import Alamofire

import Foundation
class RestService: NSObject {
    
    static let sharedInstance = RestService()
    
    func getWinkels() -> [Int:WinkelObject]? {
        
        var returnDict:[Int:WinkelObject] = [:]
        
        let json = JSON(Alamofire.request("http://localhost:3000/api/winkels"))
        for (_, object) in json {
            let winkel = WinkelObject(object)
            returnDict[Int(winkel.storeID)!] = winkel
        }
        
        return returnDict
    }
    
    func getSpringkastelenForDate(winkelId: Int, datum:Date) -> [Springkasteel: Int]? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let stringDate = dateFormatter.string(from: datum)
        
        var returnDict:[Springkasteel:Int] = [:]
        
        let endPoint = "http://localhost:3000/api/winkels"
        let post:[String:Any] = ["winkelID":String(winkelId), "datum":stringDate]
        
        let json = JSON(Alamofire.request(endPoint, method: .post, parameters: post, encoding: JSONEncoding.default))
        for(_, object) in json {
            switch(object) {
            case object["JUNGLE"]:
                returnDict[.JUNGLE] = object["JUNGLE"].intValue
            
            case object["PIRAAT"]:
                returnDict[.PIRAAT] = object["PIRAAT"].intValue
            
            case object["JUMP"]:
                returnDict[.JUMP] = object["JUMP"].intValue
                
            case object["CIRCUS"]:
                returnDict[.CIRCUS] = object["CIRCUS"].intValue
                
            default:
                break
        
            }
        }
        return returnDict
    }
    
    func maakReservatie (reservatie: Reservatie) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        let endPoint = "http://localhost:3000/api/winkels/reservatie"
        var confirmation:Bool = false
        
        let email = reservatie.klant.email
        let datumString = dateFormatter.string(from:reservatie.datum)
        
        let post:[String:Any] =
            ["winkel": String(reservatie.store.storeId),
             "type": String(describing: reservatie.springkasteel),
             "email": email,
             "datum": datumString]
        
        let json = JSON(Alamofire.request(endPoint, method: .post, parameters: post, encoding: JSONEncoding.default))
        for (_, object) in json {
            confirmation = object["confirmation"].boolValue
        }
        
        return confirmation
    }
    
    func zoekReservatie(email:String) -> [ReservatieObject]? {
        return nil
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

class ReservatieObject {
    var datum:Date?
    var type:Springkasteel?
    var winkelNaam: String
    // Placeholders
    let prijs = 99.0
    let termijn = 2
    
    required init(_ json: JSON) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let dateString = json["datum"].stringValue
        
        datum = dateFormatter.date(from:dateString)
        type = Springkasteel(rawValue: json["type"].stringValue)
        winkelNaam = json["winkel"].stringValue
        
        
    }
}

