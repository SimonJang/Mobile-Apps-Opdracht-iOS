//
//  ReservationManager.swift
//  springkasteelapp


// Facade die communiceert met de controller
// Facade delegeert alle acties voor het vastleggen van een reservatie
// Maar ook voor het opvragen van reservaties

import Foundation
class ReservationManager {
    
    // Dummy
    // Vervangen met echte service wanneer klaar
    static var tempData:DummyData = DummyData()
    static var huidigeGebruiker: String = ""
    static var geselecteerdeWinkel: Winkel? = nil
    static var geselecteerdeWinkelMetAangepasteSpringkastelen:Winkel? = nil
    static var geselecteerdeDatum: Date? = nil
    static var emailKlant: String = ""
    static var reservaties:[Reservatie] = []
    static var geselecteerdeSpringkasteel: Springkasteel?
 

    static func haalReservatieOpVoorKlantMetEmail(_ email: String) -> [Reservatie] {
        var reservaties:[Reservatie] = []
        reservaties = tempData.getReservaties(emailAdres: email) ?? []
        reservaties = reservaties.sorted(by: { $0.datum.compare($1.datum) == ComparisonResult.orderedAscending })
        return reservaties
    }
    
    static func haalSpringkastelenOp() -> [Springkasteel:Int] {
        let springKastelen = tempData.getAantalSpringkastelen(winkelId: geselecteerdeWinkel!.storeId) ?? [:]
        return springKastelen
    }
    
    static func haalSpringkasteelOp(naam: String) -> Springkasteel {
        let springkasteel = Springkasteel(rawValue: naam)
        return springkasteel!
    }

    // Beslissen welk 1 van de functies die we gaan gebruiken
    /*
    static func haalReservatieOp(idNumber: Int, email:String) -> Reservatie? {
        // Met de rest api
        if let opgevraagdeReservatie = RestService.haalReservatieOp(idNr: idNumber, emailadres: email) {
            return opgevraagdeReservatie
        }
        else {
            // De dummy data
            if let reservation = tempData.getReservaties(emailAdres: "simon@test.be") {
                return reservation
            }
            else {
                return nil
            }
        }
    }
 */
    
    // Code moet nog worden aangepast voor passende request
    // Keuze maken tussen [Int:WinkelObject] of [Int:Winkel]
    // Zelfs Int kan nog worden aangepast naar String
    
    /*
    
    func haalWinkelsOp() -> [Int:Winkel] {
        if let winkels = RestService.getWinkels() {
            return winkels
        }
        return [:]
    }
    
    /*
    
    func haalSpringkastelenOp(winkelnummer: Int) -> [Springkasteel:Int] {
        if let springkastelen = RestService.getSpringkastelen(winkelId: winkelnummer) {
            return springkastelen
        }
        return [:]
    }
    */
    
    // Haal reservatie op voor bepaalde klant
    // --> GEBRUIKT
    
 
    // Testen voor functionaliteit
    
    func controleerDatum(datum:Date, reservaties:[Reservatie]) -> [Reservatie] {
        let calendar = Calendar.current
        
        let paramYear = calendar.component(.year, from: datum)
        let paramMonth = calendar.component(.month, from: datum)
        let paramDay = calendar.component(.day, from:datum)
        
        
        
        var filteredReservaties = reservaties.filter {calendar.component(.year, from:$0.datum) == paramYear}
        filteredReservaties = reservaties.filter {calendar.component(.month, from:$0.datum) == paramMonth}
        filteredReservaties = reservaties.filter {calendar.component(.month, from:$0.datum) == paramDay}

        
        return filteredReservaties
    }
    
    // Op basis van bovenstaande filter, wordt dan de lijst van de vrije springkastelen aangepast
    
    func aanpassenBeschikbareSpringkastelen(springkastelen:[Springkasteel:Int], reservaties:[Reservatie]) -> [Springkasteel:Int] {
        return springkastelen;
    }
    
    
    // Momenteel niet toepassen
    private func haalReservatiesOp() -> [Reservatie]? {
        // Nog niet zeker of dit in de app gebeurt of in de backend
        // Met behulp van dummy data
        return nil
    }
    
    private func checkDatum() {
        // Controleren van de datum van de reservaties
        // Opties geven welke springkastelen nog beschikbaar zijn
        // Kan ook in backend gebeuren, design beslissing moet nog worden gemaakt
    }
    
}
*/
}
