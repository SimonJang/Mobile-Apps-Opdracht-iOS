

// Code gebaseerd op Sources:
//      https://devdactic.com/parse-json-with-swift/
//      https://github.com/Alamofire/Alamofire voorbeelden
//      https://github.com/SwiftyJSON/SwiftyJSON voorbeelden
//      https://grokswift.com/rest-with-alamofire-swiftyjson/ voorbeelden
//      https://medium.com/ios-os-x-development/ios-three-ways-to-pass-data-from-model-to-controller-b47cc72a4336#.ldllm277d voor delegation
//
//  Deze klasse haalt de data op van een REST service (heroku, nodejs met mongodb, zelfgeschreven)
//  Zie https://github.com/SimonJang/iOS-back-end



import SwiftyJSON
import Alamofire
import Foundation


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

// Delegate voor opvragen van winkels

protocol DataModelWinkelDelegate: class {
    func vraagWinkels(data: [WinkelObject])
}

class DataModelWinkel {
    weak var delegate: DataModelWinkelDelegate?
    
    func requestWinkels() {
        Alamofire.request("https://iosbackendspringkastelen.herokuapp.com/api/winkels").responseJSON(completionHandler:  {
            response in
            /* Controleer de call in console */
            print(response)
            
            let result = response.result.value as AnyObject
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
            Alamofire.request("https://iosbackendspringkastelen.herokuapp.com/api/reservaties/\(hashemail)").responseJSON(completionHandler: {
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

// Opvragen van reservaties van de verschillende springkastelen in winkel x op datum y

protocol DataModelBeschikbareSpringkastelenDelegate: class {
    func beschikbaarheidControlerenVoltooid()
}

class DataModelBeschikbareSpringkastelen {
    weak var delegate:DataModelBeschikbareSpringkastelenDelegate?
    
    func beschikbaarheidVoor(datum:String, inwinkel: String) {
        
        let post:[String:Any] = ["winkelID": inwinkel, "datum":datum]
        let endPoint = "https://iosbackendspringkastelen.herokuapp.com/api/winkels"

        Alamofire.request(endPoint, method: .post, parameters: post, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            print(response)
            let result = response.result.value as AnyObject
            let json = JSON(result)
            //temp testing
            let eenWinkel = ReservationManager.geselecteerdeWinkel!
            ReservationManager.geselecteerdeWinkelMetAangepasteSpringkastelen = UtilityServices.utilServices.analyseerBeschikbaarheid(vanWinkel: eenWinkel, metJSON: json)
            
            self.delegate?.beschikbaarheidControlerenVoltooid()
        })
    }
}

// Registeren van een reservatie in de backend

protocol DataModelRegistreerReservatieDelegate: class {
    func reservatieVoltooid()
    func reservatieFailure()
}

class DataModelRegistreerReservatie {
    weak var delegate:DataModelRegistreerReservatieDelegate?
    
    func registreer(reservatie: Reservatie) {
        let post:[String:Any] = ["email": reservatie.klantEmail,
                                 "datum": reservatie.datum,
                                 "storeID": reservatie.store,
                                 "springkasteel": reservatie.springkasteel]
        let endPoint = "https://iosbackendspringkastelen.herokuapp.com/api/reservatie"
        
        Alamofire.request(endPoint, method: .post, parameters: post, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            print(response)
            let result = response.result.value as AnyObject
            let json = JSON(result)
            if json["confirmation"] == "ok" {
                self.delegate?.reservatieVoltooid()
            }
            else {
                self.delegate?.reservatieFailure()
            }
        })
    }
}



