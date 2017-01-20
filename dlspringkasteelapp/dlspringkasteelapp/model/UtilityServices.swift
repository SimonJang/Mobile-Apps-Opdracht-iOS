//
//  UtilityServices.swift
//  dlspringkasteelapp
//


/*
  Klasse voor verschillende conversies toe te passen van/naar verschillende objecten (date,
 */

import Foundation

class UtilityServices {
    static let utilServices = UtilityServices()
    
    
    // Hash functie voor verbergen van email adres in GET request
    // zie http://stackoverflow.com/questions/39400495/md5-of-data-in-swift-3
    // en http://stackoverflow.com/questions/24123518/how-to-use-cc-md5-method-in-swift-language
    
    func md5(string: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = string.data(using: String.Encoding.utf8) {
            CC_MD5(data.withUnsafeBytes { bytes in
                CC_MD5(bytes, CC_LONG(data.count), &digest)
            }, CC_LONG(data.count), &digest)
        }
        
        var returnString = ""
        
        for x in digest {
            returnString += String(x)
        }
        
        return returnString
    }
    
    func convertWinkelObjectToWinkelDict(input:[WinkelObject]?) -> [Int:Winkel] {
        var returnDict:[Int:Winkel] = [:]
        
        if input != nil {
            for winkelObj in input! {
                returnDict[Int(winkelObj.storeID)!] = Winkel(storeID: Int(winkelObj.storeID)!, storeNAME: winkelObj.naam)
            }
        }
        
        return returnDict
    }
    
}
