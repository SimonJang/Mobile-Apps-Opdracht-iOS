//
//  Tempdata.swift
//  springkasteelapp

// Dummy data voor het ophalen voor de winkels,springkastelen en mogelijk ook reservaties


import Foundation
class DummyData {
    var winkels:[Int:Winkel] = [:]
    
    func getWinkels() -> [Int:Winkel]? {
        let winkelDummy:Dictionary<Int, Winkel> = [
            3957: Winkel(storeID: 3957, storeNAME: "DreamLand Gent"),
            3945: Winkel(storeID: 3945, storeNAME: "DreamLand Lochristi"),
            3977: Winkel(storeID: 3977, storeNAME: "DreamLand Eeklo"),
            3969: Winkel(storeID: 3969, storeNAME: "DreamLand Brugge")
        ]
        winkels = winkelDummy
        return winkelDummy
    }
    
    
    func getAantalSpringkastelen(winkelId: Int) -> [Springkasteel: Int]? {
        var springkastelen:Dictionary<Springkasteel,Int> = [.JUNGLE: 0, .PIRAAT: 0, .CIRCUS: 0, .JUMP: 0]
        switch(winkelId) {
        case 3957:
            springkastelen = assignToDictionary(springkasteel: .JUNGLE, aantal: 2, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .CIRCUS, aantal: 4, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .PIRAAT, aantal: 4, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .JUMP, aantal: 1, dataInput: &springkastelen)
            return springkastelen
        case 3945:
            springkastelen = assignToDictionary(springkasteel: .JUNGLE, aantal: 1, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .CIRCUS, aantal: 1, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .PIRAAT, aantal: 1, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .JUMP, aantal: 1, dataInput: &springkastelen)
            return springkastelen
        case 3977:
            springkastelen = assignToDictionary(springkasteel: .JUNGLE, aantal: 2, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .CIRCUS, aantal: 2, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .PIRAAT, aantal: 2, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .JUMP, aantal: 2, dataInput: &springkastelen)
            return springkastelen
        case 3969:
            springkastelen = assignToDictionary(springkasteel: .JUNGLE, aantal: 3, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .CIRCUS, aantal: 3, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .PIRAAT, aantal: 3, dataInput: &springkastelen)
            springkastelen = assignToDictionary(springkasteel: .JUMP, aantal: 3, dataInput: &springkastelen)
            return springkastelen
        default:
            return nil
        }
        
    }
    
    func getReservaties(emailAdres: String) -> [Reservatie]? {
        var reservaties:[Reservatie] = []
        getWinkels()
        let klant = Klant(f_name: "Simon",l_name: "Jang", klantEmail: "simon@test.be")
        let date = Date() - 800000
        if(emailAdres == "simon@test.be") {
            reservaties.append(Reservatie(klant: klant, gewenstSpringkasteel: .JUNGLE, datum: date, afhaalwinkel: winkels[3957]!, termijn: 2, teBetalen: 99.00))
            reservaties.append(Reservatie(klant: klant, gewenstSpringkasteel: .JUNGLE, datum: date-500000, afhaalwinkel: winkels[3957]!, termijn: 2, teBetalen: 99.00))
            reservaties.append(Reservatie(klant: klant, gewenstSpringkasteel: .JUNGLE, datum: date-100000, afhaalwinkel: winkels[3957]!, termijn: 2, teBetalen: 99.00))
        }
        return reservaties
    }
    
    private func assignToDictionary(springkasteel:Springkasteel, aantal: Int, dataInput:inout Dictionary<Springkasteel,Int>) -> [Springkasteel:Int] {
        dataInput[springkasteel] = aantal
        return dataInput
    }
    
}
