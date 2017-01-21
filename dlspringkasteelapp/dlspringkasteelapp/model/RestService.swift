//
//  RestService.swift
//  springkasteelapp

// Code gebaseerd op
//      https://devdactic.com/parse-json-with-swift/
//      https://github.com/Alamofire/Alamofire voorbeelden
//      https://github.com/SwiftyJSON/SwiftyJSON voorbeelden
//      https://grokswift.com/rest-with-alamofire-swiftyjson/ voorbeelden
//      https://medium.com/ios-os-x-development/ios-three-ways-to-pass-data-from-model-to-controller-b47cc72a4336#.ldllm277d voor delegation
//
//  Deze klasse haalt de data op van een REST service



import SwiftyJSON
import Alamofire

import Foundation
class RestService {
    
    static let sharedInstance = RestService()
    var sessionManager: SessionManager!
    var returnWinkels:[WinkelObject] = []
 
    
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
    
    /*
    
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
    
    func zoekReservaties(email:String) -> [ReservatieObject]? {
        let hashed = UtilityServices.utilServices.MD5(string: email)
        let endPoint = "http://localhost:3000/api/reservaties/\(hashed)"
        var reservatiesArr:[ReservatieObject]? = nil
        
        let json = JSON(Alamofire.request(endPoint))
        for(_, object) in json {
            reservatiesArr?.append(ReservatieObject(object))
        }
        
        return reservatiesArr
        
    }
     
     */
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
    
    required init(_ json:JSON) {
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

// Delegate voor opvragen van winkels

protocol DataModelWinkelDelegate: class {
    func vraagWinkels(data: [WinkelObject])
}

class DataModelWinkel {
    weak var delegate: DataModelWinkelDelegate?
    
    func requestWinkels() {
        Alamofire.request("http://localhost:3000/api/winkels").responseJSON(completionHandler:  {
            response in
            /* Controleer de call in console */
            print(response)
            guard let result = response.result.value as? AnyObject else {
                print("Something went wrong with GET REQUEST to http://localhost:3000/api/winkels")
                print("Error: \(response.result.error)")
                return
            }
            var winkels:[WinkelObject] = []
            let json = JSON(result)
            for(_, object) in json {
                let winkel = WinkelObject(object)
                winkels.append(winkel)
            }
            self.delegate?.vraagWinkels(data: winkels)
        })
        
    }
}

// Delegate voor opvragen van reservaties voor specifieke klant

protocol DataModelReservatieOpvragenKlantDelegate: class {
    func vraagReservaties(data: [Reservatie])
}

class DataModelReservatieOpvragenKlant {
    weak var delegate: DataModelReservatieOpvragenKlantDelegate?
    
    func requestReservatiesVoor(emailklant: String) {
        if let hashemail = UtilityServices.utilServices.MD5(string: emailklant) {
            Alamofire.request("http://localhost:3000/api/reservaties/\(hashemail)").responseJSON(completionHandler: {
                response in
                // Controleer de call in console */
                print(response)
                let result = response.result.value as AnyObject
                var reservaties:[Reservatie] = []
                let json = JSON(result)
                for(_,object) in json {
                    let reservatie = Reservatie(klant: object["email"].stringValue,
                                                gewenstSpringkasteel: object["springkasteel"].stringValue,
                                                datum: object["datum"].stringValue,
                                                afhaalwinkel: object["storeID"].stringValue,
                                                termijn: Int(object["termijn"].stringValue)!)
                    reservaties.append(reservatie)
                }
                self.delegate?.vraagReservaties(data: reservaties)
            })
        }
    }
}

// Controleren van beschikbaarheid van springkasteel

protocol DataModelBeschikbareSpringkastelenDelegate: class {
    func beschikbaarheidControlerenVoltooid()
}

class DataModelBeschikbareSpringkastelen {
    weak var delegate:DataModelBeschikbareSpringkastelenDelegate?
    
    func beschikbaarheidVoor(datum:String, inwinkel: String) {
        
        let post:[String:Any] = ["winkelID": inwinkel, "datum":datum]
        let endPoint = "http://localhost:3000/api/winkels"

        Alamofire.request(endPoint, method: .post, parameters: post, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            print(response)
            let result = response.result.value as AnyObject
            let json = JSON(result)
            ReservationManager.geselecteerdeWinkel = UtilityServices.utilServices.analyseerBeschikbaarheid(vanWinkel: &ReservationManager.geselecteerdeWinkel!, metJSON: json)
            
            self.delegate?.beschikbaarheidControlerenVoltooid()
        })
    }
}



