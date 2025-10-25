import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> StationEntry {
        StationEntry(date: Date(), departures: [], stationName: "Loading...", error: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (StationEntry) -> ()) {
        let entry = StationEntry(
            date: Date(),
            departures: [
                Departure(
                    std: "14:30",
                    etd: "On time",
                    platform: "1",
                    operatorName: "GWR",
                    destination: [Destination(locationName: "Bristol Temple Meads", crs: "BRI")],
                    serviceID: "1"
                ),
                Departure(
                    std: "14:35",
                    etd: "14:40",
                    platform: "2",
                    operatorName: "SWR",
                    destination: [Destination(locationName: "Portsmouth Harbour", crs: "PMH")],
                    serviceID: "2"
                )
            ],
            stationName: "Waterloo",
            error: nil
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let station = getRandomStation()
            var entry: StationEntry
            
            guard let apiToken = ProcessInfo.processInfo.environment["NATIONAL_RAIL_API_TOKEN"] else {
                entry = StationEntry(
                    date: Date(),
                    departures: [],
                    stationName: station.name,
                    error: "API token required"
                )
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
                return
            }
            
            do {
                let departures = try await NationalRailService.shared.fetchDepartures(
                    for: station.crs,
                    apiToken: apiToken
                )
                entry = StationEntry(
                    date: Date(),
                    departures: departures,
                    stationName: station.name,
                    error: nil
                )
            } catch {
                entry = StationEntry(
                    date: Date(),
                    departures: [],
                    stationName: station.name,
                    error: "No data"
                )
            }
            
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }
}

struct StationEntry: TimelineEntry {
    let date: Date
    let departures: [Departure]
    let stationName: String
    let error: String?
}

struct NationalRailWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack(alignment: .leading, spacing: 8) {
                Text(entry.stationName.uppercased())
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(.yellow)
                    .padding(.bottom, 4)
                
                if let error = entry.error {
                    Text(error.uppercased())
                        .font(.system(size: 14, weight: .medium, design: .monospaced))
                        .foregroundColor(.yellow)
                } else if entry.departures.isEmpty {
                    Text("NO TRAINS")
                        .font(.system(size: 14, weight: .medium, design: .monospaced))
                        .foregroundColor(.yellow)
                } else {
                    ForEach(entry.departures) { departure in
                        HStack(alignment: .top, spacing: 8) {
                            Text(departure.std)
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(.yellow)
                                .frame(width: 50, alignment: .leading)
                            
                            Text(departure.destinationName.uppercased())
                                .font(.system(size: 11, weight: .medium, design: .monospaced))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(departure.platform ?? "-")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(.yellow)
                                .frame(width: 30, alignment: .center)
                            
                            Text(departure.etd.uppercased())
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(departure.etd == "On time" ? .yellow : .orange)
                                .frame(width: 60, alignment: .trailing)
                                .lineLimit(1)
                        }
                        
                        if departure.id != entry.departures.last?.id {
                            Divider()
                                .background(Color.yellow.opacity(0.3))
                        }
                    }
                }
                
                Spacer()
            }
            .padding(12)
        }
    }
}

struct NationalRailWidget: Widget {
    let kind: String = "NationalRailWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            NationalRailWidgetEntryView(entry: entry)
                .containerBackground(.black, for: .widget)
        }
        .configurationDisplayName("National Rail Departures")
        .description("Live train departures at a random UK train station")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    NationalRailWidget()
} timeline: {
    StationEntry(
        date: Date(),
        departures: [
            Departure(
                std: "14:30",
                etd: "On time",
                platform: "1",
                operatorName: "GWR",
                destination: [Destination(locationName: "Bristol Temple Meads", crs: "BRI")],
                serviceID: "1"
            ),
            Departure(
                std: "14:35",
                etd: "14:40",
                platform: "2",
                operatorName: "SWR",
                destination: [Destination(locationName: "Portsmouth Harbour", crs: "PMH")],
                serviceID: "2"
            ),
            Departure(
                std: "14:42",
                etd: "On time",
                platform: "3",
                operatorName: "SWR",
                destination: [Destination(locationName: "Weymouth", crs: "WEY")],
                serviceID: "3"
            )
        ],
        stationName: "Waterloo",
        error: nil
    )
}
