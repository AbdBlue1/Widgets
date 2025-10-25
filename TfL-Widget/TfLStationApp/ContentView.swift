import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "tram.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("TfL Station Arrivals")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Add the widget to your home screen to see live train arrivals")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
