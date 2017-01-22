
// Repository die communiceert met de controllers
// Blijkt na het afwerken van de app eigenlijk een 'nutteloze' klasse die enkel values bewaart die nodig zijn voor de controllers

import Foundation
class ReservationManager {
    
    static var huidigeGebruiker: String = ""
    static var geselecteerdeWinkel: Winkel? = nil
    static var geselecteerdeWinkelMetAangepasteSpringkastelen:Winkel? = nil
    static var geselecteerdeDatum: String?
    static var emailKlant: String = ""
    static var reservaties:[Reservatie] = []
    static var geselecteerdeSpringkasteel: Springkasteel?
    
    }
