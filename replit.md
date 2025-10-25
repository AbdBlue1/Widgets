# TfL Station Arrivals Widget

A minimal iOS app with a SwiftUI widget that displays live train arrivals at random London Underground stations in a simple station departure board style.

## Overview

This is an iOS application built with SwiftUI and WidgetKit that shows real-time train arrivals from Transport for London (TfL) Underground stations. The widget displays arrival information in a classic station board aesthetic with a black background and yellow/white text.

## Project Structure

```
TfLStationWidget/
├── Shared/
│   ├── Models.swift          # Data models (Arrival, Station)
│   └── TfLService.swift      # TfL API service for fetching arrivals
├── TfLStationApp/
│   ├── TfLStationApp.swift   # Main app entry point
│   └── ContentView.swift     # Main app view
└── TfLStationWidget/
    ├── TfLStationWidget.swift # Widget implementation with TimelineProvider
    └── Info.plist            # Widget extension configuration
```

## Features

- **Simple Station Board UI**: Black background with yellow/white monospaced text for authentic station board look
- **Live Train Arrivals**: Fetches real-time data from TfL API showing line name, destination, and minutes until arrival
- **Random Station Selection**: Randomly selects from 8 popular London Underground stations
- **Auto-refresh**: Widget updates every 15 minutes using TimelineProvider
- **Error Handling**: Gracefully displays "No data" when API calls fail
- **Native Implementation**: Uses only native URLSession, no external dependencies

## Popular Stations Included

- King's Cross St. Pancras
- Liverpool Street
- Oxford Circus
- Baker Street
- Victoria
- Piccadilly Circus
- Westminster
- Bond Street

## Requirements

- iOS 17.0+
- Xcode 15.0+
- macOS for development

## How to Build and Run

⚠️ **Important**: This is an iOS application that requires Xcode on macOS to build and run.

### Setup in Xcode

1. **Open in Xcode**:
   - Download all files to your Mac
   - Open Xcode and create a new iOS App project
   - Set the app name to "TfLStationWidget" and choose SwiftUI as the interface
   - Add a Widget Extension target (File → New → Target → Widget Extension)
   - Name it "TfLStationWidget"

2. **Add the Files**:
   - Copy `Shared/Models.swift` and `Shared/TfLService.swift` to your project (add to both targets)
   - Replace the auto-generated ContentView.swift with `TfLStationApp/ContentView.swift`
   - Replace the auto-generated widget file with `TfLStationWidget/TfLStationWidget.swift`
   - Ensure both files are added to the Widget Extension target

3. **Configure Targets**:
   - Main app target: Include TfLStationApp.swift, ContentView.swift, Models.swift, TfLService.swift
   - Widget Extension target: Include TfLStationWidget.swift, Models.swift, TfLService.swift
   - Set deployment target to iOS 17.0+ for both targets

4. **Build and Run**:
   - Select your device or simulator
   - Build and run the app (⌘R)
   - Long-press on the home screen to add the widget
   - Select "TfL Station Arrivals" widget

## API Information

The app uses the TfL Unified API to fetch live arrival data:
- **Endpoint**: `https://api.tfl.gov.uk/StopPoint/{stationId}/Arrivals`
- **No API key required** for basic usage
- **Rate limits**: Reasonable for personal use; consider registering for an API key for production

## Widget Design

The widget follows a simple station departure board aesthetic:
- **Background**: Solid black (#000000)
- **Station name**: Yellow, bold, uppercase, monospaced font
- **Line names**: Yellow text (left column)
- **Destinations**: White text (middle, truncated if needed)
- **Arrival times**: Yellow text showing minutes (right column)
- **Dividers**: Subtle yellow dividers between rows

## Recent Changes

- 2025-01-25: Initial project creation
- Implemented TfL API integration for station arrivals
- Created station board styled widget with black/yellow theme
- Added random station selection from 8 popular Underground stations
- Configured 15-minute refresh interval

## User Preferences

- Simple, clean design without unnecessary complexity
- Station board aesthetic (not over-designed)
- Focus on readability and authentic look

## Technical Notes

- Uses Swift 5.8+ language features
- Async/await for API calls
- Codable for JSON parsing
- TimelineProvider for widget refresh scheduling
- Error handling with try/catch and graceful fallbacks
