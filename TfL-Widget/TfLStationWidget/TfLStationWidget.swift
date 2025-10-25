import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> StationEntry {
        StationEntry(date: Date(), arrivals: [], stationName: "Loading...", error: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (StationEntry) -> ()) {
        let entry = StationEntry(
            date: Date(),
            arrivals: [
                Arrival(id: "1", lineName: "Central", destinationName: "Ealing Broadway", timeToStation: 120, platformName: "1"),
                Arrival(id: "2", lineName: "Victoria", destinationName: "Brixton", timeToStation: 180, platformName: "2")
            ],
            stationName: "King's Cross",
            error: nil
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let station = getRandomStation()
            var entry: StationEntry
            
            do {
                let arrivals = try await TfLService.shared.fetchArrivals(for: station.id)
                entry = StationEntry(
                    date: Date(),
                    arrivals: arrivals,
                    stationName: station.name,
                    error: nil
                )
            } catch {
                entry = StationEntry(
                    date: Date(),
                    arrivals: [],
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
    let arrivals: [Arrival]
    let stationName: String
    let error: String?
}

struct TfLStationWidgetEntryView : View {
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
                } else if entry.arrivals.isEmpty {
                    Text("NO TRAINS")
                        .font(.system(size: 14, weight: .medium, design: .monospaced))
                        .foregroundColor(.yellow)
                } else {
                    ForEach(entry.arrivals) { arrival in
                        HStack(alignment: .top, spacing: 8) {
                            Text(arrival.lineName.uppercased())
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(.yellow)
                                .frame(width: 60, alignment: .leading)
                            
                            Text(arrival.destinationName.uppercased())
                                .font(.system(size: 11, weight: .medium, design: .monospaced))
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("\(arrival.minutesToArrival) MIN")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(.yellow)
                                .frame(width: 50, alignment: .trailing)
                        }
                        
                        if arrival.id != entry.arrivals.last?.id {
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

struct TfLStationWidget: Widget {
    let kind: String = "TfLStationWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TfLStationWidgetEntryView(entry: entry)
                .containerBackground(.black, for: .widget)
        }
        .configurationDisplayName("TfL Station Arrivals")
        .description("Live train arrivals at a random London Underground station")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    TfLStationWidget()
} timeline: {
    StationEntry(
        date: Date(),
        arrivals: [
            Arrival(id: "1", lineName: "Central", destinationName: "Ealing Broadway", timeToStation: 120, platformName: "1"),
            Arrival(id: "2", lineName: "Victoria", destinationName: "Brixton", timeToStation: 180, platformName: "2"),
            Arrival(id: "3", lineName: "Jubilee", destinationName: "Stanmore", timeToStation: 300, platformName: "3")
        ],
        stationName: "King's Cross",
        error: nil
    )
}
