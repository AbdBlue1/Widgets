import Foundation

struct Departure: Codable, Identifiable {
    let std: String
    let etd: String
    let platform: String?
    let operatorName: String
    let destination: [Destination]
    let serviceID: String
    
    enum CodingKeys: String, CodingKey {
        case std
        case etd
        case platform
        case operatorName = "operator"
        case destination
        case serviceID
    }
    
    var id: String { serviceID }
    
    var destinationName: String {
        destination.first?.locationName ?? "Unknown"
    }
    
    var estimatedDeparture: String {
        etd == "On time" ? std : etd
    }
}

struct Destination: Codable {
    let locationName: String
    let crs: String
}

struct DepartureBoardResponse: Codable {
    let trainServices: [Departure]?
    let locationName: String
    let crs: String
}

struct Station {
    let crs: String
    let name: String
}

let popularStations = [
    Station(crs: "KGX", name: "King's Cross"),
    Station(crs: "PAD", name: "Paddington"),
    Station(crs: "EUS", name: "Euston"),
    Station(crs: "VIC", name: "Victoria"),
    Station(crs: "WAT", name: "Waterloo"),
    Station(crs: "LBG", name: "London Bridge"),
    Station(crs: "LST", name: "Liverpool Street"),
    Station(crs: "STP", name: "St Pancras")
]

func getRandomStation() -> Station {
    return popularStations.randomElement() ?? popularStations[0]
}
