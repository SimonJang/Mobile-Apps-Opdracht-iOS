//
//  UtilityServices.swift
//  dlspringkasteelapp
//


/*
  Klasse voor verschillende conversies toe te passen van/naar verschillende objecten
  Hashing dient hier voor GET voor de reservaties op te halen van de klant, email wordt gehashed en GET parameter
 */

import Foundation

class UtilityServices {
    static let utilServices = UtilityServices()
    
    // Omzetten van String naar MD5 hash voor bij GET requests het email te maskeren
    // http://stackoverflow.com/questions/32163848/how-to-convert-string-to-md5-hash-using-ios-swift
    
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
                returnDict[Int(winkelObj.storeID)!] = Winkel(storeID: Int(winkelObj.storeID)!, storeNAME: winkelObj.naam)
            }
        }
        
        return returnDict
    }
    
    // Gebruik van regex voor validatie
    // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    
    func validateEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
}
