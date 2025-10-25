import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "train.side.front.car")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text("National Rail Departures")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Add the widget to your home screen to see live train departures")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Text("Note: Requires National Rail API token")
                .font(.caption)
                .foregroundColor(.orange)
                .padding(.top, 10)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
