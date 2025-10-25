# TfL Station Arrivals Widget for iOS

A minimal iOS widget displaying live London Underground train arrivals in a classic station board style.

## Quick Start

This is an iOS app that requires **Xcode on macOS** to build and run.

### Setup Instructions

1. Open Xcode and create a new iOS App project
2. Add a Widget Extension target
3. Copy the Swift files from this repository to your Xcode project:
   - `Shared/Models.swift` → Add to both app and widget targets
   - `Shared/TfLService.swift` → Add to both app and widget targets
   - `TfLStationApp/ContentView.swift` → Main app target
   - `TfLStationWidget/TfLStationWidget.swift` → Widget extension target
4. Build and run on your device or simulator (iOS 17+)
5. Add the widget to your home screen

## Features

✅ Simple station board design (black background, yellow/white text)  
✅ Live data from TfL API  
✅ Random station selection from 8 popular Underground stations  
✅ Auto-refresh every 15 minutes  
✅ Shows line name, destination, and arrival time  
✅ Native implementation, no external dependencies  

## Widget Preview

The widget displays:
- Station name at the top
- Up to 4 upcoming trains
- Line name (e.g., "CENTRAL")
- Destination (e.g., "EALING BROADWAY")
- Minutes until arrival (e.g., "2 MIN")

All in uppercase monospaced font on a black background for that authentic station board feel.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- SwiftUI & WidgetKit

## API

Uses the free TfL Unified API:  
`https://api.tfl.gov.uk/StopPoint/{stationId}/Arrivals`

No API key required for basic usage.
