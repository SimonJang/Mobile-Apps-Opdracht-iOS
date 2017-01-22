
/*
  Klasse voor verschillende conversies toe te passen van/naar verschillende objecten
  Hashing dient hier voor GET voor de reservaties op te halen van de klant, email wordt gehashed en GET parameter
 */

import Foundation
import SwiftyJSON

class UtilityServices {
    static let utilServices = UtilityServices()
    
    // Omzetten van String naar MD5 hash voor bij GET requests het email te maskeren
    // Source: http://stackoverflow.com/questions/32163848/how-to-convert-string-to-md5-hash-using-ios-swift
    
    func MD5(string: String) -> String? {
        guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        let MD5HashedString =  digestData.map { String(format: "%02hhx", $0) }.joined()
        
        return MD5HashedString
    }

    // Converteren van WinkelObject naar Winkel
    // Indien tijd, refactor
    
    func convertWinkelObjectToWinkelDict(input:[WinkelObject]?) -> [Int:Winkel] {
        var returnDict:[Int:Winkel] = [:]
        
        if input != nil {
            for winkelObj in input! {
                let winkel = Winkel(storeID: Int(winkelObj.storeID)!, storeNAME: winkelObj.naam)
                winkel.CIRCUS = winkelObj.CIRCUS
                winkel.JUMP = winkelObj.JUMP
                winkel.PIRAAT = winkelObj.PIRAAT
                winkel.JUNGLE = winkelObj.JUNGLE
                returnDict[Int(winkelObj.storeID)!] = winkel
            }
        }
        
        return returnDict
    }
    
    // Gebruik van regex voor validatie
    // Source: http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    
    func validateEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // Functie kijkt welke springkastelen er allemaal beschikbaar zijn in bepaalde winkel op basis van json input

    func analyseerBeschikbaarheid(vanWinkel: Winkel, metJSON: JSON) -> Winkel {
        let gefilterdeWinkel = Winkel(storeID: vanWinkel.storeId, storeNAME: vanWinkel.storeName)
        gefilterdeWinkel.CIRCUS = Int(vanWinkel.CIRCUS)
        gefilterdeWinkel.PIRAAT = Int(vanWinkel.PIRAAT)
        gefilterdeWinkel.JUMP = Int(vanWinkel.JUMP)
        gefilterdeWinkel.JUNGLE = Int(vanWinkel.JUNGLE)
        for(_, object) in metJSON {
            let type = object["springkasteel"].stringValue
            switch(type) {
                case "jungle":
                    gefilterdeWinkel.JUNGLE = gefilterdeWinkel.JUNGLE - 1
                case "piraat":
                    gefilterdeWinkel.PIRAAT = gefilterdeWinkel.PIRAAT - 1
                case "circus":
                    gefilterdeWinkel.CIRCUS = gefilterdeWinkel.CIRCUS - 1
                case "jump":
                    gefilterdeWinkel.JUMP = gefilterdeWinkel.JUMP - 1
            default: break
            }
        }
        return gefilterdeWinkel
    }
    
    func convertDatumNaarString(datum:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let stringDate = dateFormatter.string(from: datum)
        return stringDate
    }
    
    func convertStringNaarDatum(stringDatum:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let someDate = dateFormatter.date(from: stringDatum)
        return someDate!
    }
    
}
