# UK Transport iOS Widgets

Two separate iOS widget projects displaying live transport information in a classic station board style.

## 📱 Projects Included

### 1. TfL Station Arrivals Widget
Live London Underground train arrivals at random stations.

📁 **Location**: `TfL-Widget/`  
🔗 **API**: Transport for London (TfL) - No API key required  
📍 **Stations**: King's Cross, Liverpool Street, Oxford Circus, Baker Street, Victoria, Piccadilly Circus, Westminster, Bond Street

### 2. National Rail Departures Widget
Live UK train departures at random major stations.

📁 **Location**: `NationalRail-Widget/`  
🔗 **API**: National Rail via Huxley proxy - Free API token required  
📍 **Stations**: King's Cross, Paddington, Euston, Victoria, Waterloo, London Bridge, Liverpool Street, St Pancras

## ✨ Features (Both Apps)

- **Station Board Design**: Black background with yellow/white monospaced text
- **Live Data**: Real-time transport information
- **Random Stations**: Each refresh picks a different station
- **Auto-Refresh**: Updates every 15 minutes
- **Error Handling**: Shows "No data" gracefully when API is unavailable
- **100% Native**: SwiftUI and WidgetKit only, no external dependencies

## 🚀 Setup

Both apps require **Xcode on macOS** to build and run.

### TfL Widget Setup
1. No API key needed
2. See `TfL-Widget/README.md` for detailed instructions

### National Rail Widget Setup
1. Register for free API token at https://realtime.nationalrail.co.uk/OpenLDBWSRegistration
2. See `NationalRail-Widget/README.md` for detailed instructions

## 📂 Project Structure

```
.
├── TfL-Widget/
│   ├── Shared/
│   │   ├── Models.swift
│   │   └── TfLService.swift
│   ├── TfLStationApp/
│   │   ├── TfLStationApp.swift
│   │   └── ContentView.swift
│   ├── TfLStationWidget/
│   │   ├── TfLStationWidget.swift
│   │   └── Info.plist
│   ├── Package.swift
│   └── README.md
│
├── NationalRail-Widget/
│   ├── Shared/
│   │   ├── Models.swift
│   │   └── NationalRailService.swift
│   ├── NationalRailApp/
│   │   ├── NationalRailApp.swift
│   │   └── ContentView.swift
│   ├── NationalRailWidget/
│   │   ├── NationalRailWidget.swift
│   │   └── Info.plist
│   ├── Package.swift
│   └── README.md
│
└── preview/
    ├── index.html (TfL preview)
    └── nationalrail.html (National Rail preview)
```

## 🎨 Web Previews

Web-based mockups are available to see what the widgets look like:

- **TfL Widget**: Open `preview/index.html` in browser
- **National Rail Widget**: Open `preview/nationalrail.html` in browser

These previews fetch real live data and demonstrate the exact appearance of the iOS widgets.

## 📋 Requirements

- iOS 17.0+
- Xcode 15.0+
- macOS for development
- SwiftUI & WidgetKit

## 🔒 Security

- TfL API requires no authentication
- National Rail API token stored in environment variables (never hardcoded)
- No external dependencies or third-party SDKs

## 📖 Documentation

Each project has its own detailed README:
- `TfL-Widget/README.md`
- `NationalRail-Widget/README.md`

## 🎯 Design Philosophy

Simple, clean, authentic station board aesthetic without unnecessary complexity. Focus on readability and the classic look of UK transport departure boards.
