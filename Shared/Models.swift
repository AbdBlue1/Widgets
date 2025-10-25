import Foundation

struct Arrival: Codable, Identifiable {
    let id: String
    let lineName: String
    let destinationName: String
    let timeToStation: Int
    let platformName: String?
    
    var minutesToArrival: Int {
        return timeToStation / 60
    }
}

struct Station {
    let id: String
    let name: String
}

let popularStations = [
    Station(id: "940GZZLUKSX", name: "King's Cross St. Pancras"),
    Station(id: "940GZZLULVT", name: "Liverpool Street"),
    Station(id: "940GZZLUOXC", name: "Oxford Circus"),
    Station(id: "940GZZLUBST", name: "Baker Street"),
    Station(id: "940GZZLUVIC", name: "Victoria"),
    Station(id: "940GZZLUPAC", name: "Piccadilly Circus"),
    Station(id: "940GZZLUWSM", name: "Westminster"),
    Station(id: "940GZZLUBND", name: "Bond Street")
]

func getRandomStation() -> Station {
    return popularStations.randomElement() ?? popularStations[0]
}
