
// Attributen van de winkel

import Foundation
class Winkel {
    var storeId: Int;
    var storeName: String;
    var adresWinkel: String = ""
    var telefoonNummerWinkel: String = ""
    var JUNGLE: Int = 0
    var PIRAAT: Int = 0
    var CIRCUS: Int = 0
    var JUMP: Int = 0
    
    init(storeID: Int, storeNAME: String) {
        self.storeId = storeID;
        self.storeName = storeNAME;
    }
}
