import Foundation

class TfLService {
    static let shared = TfLService()
    
    private init() {}
    
    func fetchArrivals(for stationId: String) async throws -> [Arrival] {
        let urlString = "https://api.tfl.gov.uk/StopPoint/\(stationId)/Arrivals"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let arrivals = try JSONDecoder().decode([Arrival].self, from: data)
        
        return arrivals
            .filter { $0.timeToStation > 0 }
            .sorted { $0.timeToStation < $1.timeToStation }
            .prefix(4)
            .map { $0 }
    }
}
