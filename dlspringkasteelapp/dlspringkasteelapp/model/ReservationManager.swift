//
//  ReservationManager.swift
//  springkasteelapp


// Facade die communiceert met de controller
// Facade delegeert alle acties voor het vastleggen van een reservatie
// Maar ook voor het opvragen van reservaties

import Foundation
class ReservationManager {
    
    // Dummy
    var tempData:DummyData = DummyData()
    
    func maakReservatie(klantVoorReservatie: Klant,springkasteel: Springkasteel, winkel: Winkel, date:Date) -> Bool {
        let nieuweReservatie = Reservatie(klant:klantVoorReservatie, gewenstSpringkasteel: springkasteel, datum: date, afhaalwinkel: winkel, termijn: 1, teBetalen: 99.00)
        RestService.maakReservatie(reservatie: nieuweReservatie)
        return false
    }
    
    func haalReservatieOp(idNumber: Int, email:String) -> Reservatie? {
        // Met de rest api
        if let opgevraagdeReservatie = RestService.haalReservatieOp(idNr: idNumber, emailadres: email) {
            return opgevraagdeReservatie
        }
        else {
            // De dummy data
            if let reservation = tempData.getReservaties(idNr: "12345678", emailAdres: "simon@test.be") {
                return reservation
            }
            else {
                return nil
            }
        }
    }
    
    func haalWinkelsOp() -> [Int:Winkel] {
        if let winkels = RestService.getWinkels() {
            return winkels
        }
        return [:]
    }
    
    func haalSpringkastelenOp(winkelnummer: Int) -> [Springkasteel:Int] {
        if let springkastelen = RestService.getSpringkastelen(winkelId: winkelnummer) {
            return springkastelen
        }
        return [:]
    }
    
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
