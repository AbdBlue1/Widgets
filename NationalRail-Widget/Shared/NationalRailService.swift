import Foundation

class NationalRailService {
    static let shared = NationalRailService()
    
    private init() {}
    
    func fetchDepartures(for stationCRS: String, apiToken: String) async throws -> [Departure] {
        let urlString = "https://huxley2.azurewebsites.net/departures/\(stationCRS)/10"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiToken, forHTTPHeaderField: "AccessToken")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let boardResponse = try JSONDecoder().decode(DepartureBoardResponse.self, from: data)
        
        return boardResponse.trainServices?
            .prefix(4)
            .map { $0 } ?? []
    }
}
