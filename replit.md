# UK Transport iOS Widgets

Two separate iOS widget applications displaying live transport information in a classic station board style.

## Overview

This repository contains two complete iOS applications, each with a home screen widget:

1. **TfL Station Arrivals Widget** - London Underground live arrivals
2. **National Rail Departures Widget** - UK train departures

Both share the same simple station board aesthetic: black background with yellow/white monospaced text, mimicking real UK transport departure boards.

## Project Structure

```
.
├── TfL-Widget/                 # London Underground widget app
│   ├── Shared/
│   │   ├── Models.swift        # Data models for TfL arrivals
│   │   └── TfLService.swift    # TfL API service
│   ├── TfLStationApp/
│   │   ├── TfLStationApp.swift # App entry point
│   │   └── ContentView.swift   # Main app view
│   ├── TfLStationWidget/
│   │   ├── TfLStationWidget.swift # Widget with TimelineProvider
│   │   └── Info.plist          # Widget configuration
│   └── Package.swift
│
├── NationalRail-Widget/        # National Rail widget app
│   ├── Shared/
│   │   ├── Models.swift        # Data models for departures
│   │   └── NationalRailService.swift # National Rail API service
│   ├── NationalRailApp/
│   │   ├── NationalRailApp.swift # App entry point
│   │   └── ContentView.swift   # Main app view
│   ├── NationalRailWidget/
│   │   ├── NationalRailWidget.swift # Widget with TimelineProvider
│   │   └── Info.plist          # Widget configuration
│   └── Package.swift
│
└── preview/                    # Web-based previews
    ├── index.html              # TfL widget preview
    └── nationalrail.html       # National Rail preview
```

## Features (Both Apps)

- **Station Board Design**: Black background with yellow/white monospaced text
- **Live Data**: Real-time API integration
- **Random Stations**: Each refresh picks from 8 popular stations
- **Auto-refresh**: Widgets update every 15 minutes via TimelineProvider
- **Error Handling**: Graceful fallback showing "No data" when API fails
- **Native Implementation**: SwiftUI and WidgetKit only, no external dependencies
- **iOS 17+**: Modern Swift features with async/await

## TfL Widget Details

**API**: Transport for London Unified API  
**Endpoint**: `https://api.tfl.gov.uk/StopPoint/{stationId}/Arrivals`  
**Authentication**: None required  
**Data Displayed**:
- Station name
- Line name (e.g., Central, Victoria)
- Destination
- Minutes until arrival

**Stations**: King's Cross, Liverpool Street, Oxford Circus, Baker Street, Victoria, Piccadilly Circus, Westminster, Bond Street

## National Rail Widget Details

**API**: National Rail via Huxley REST proxy  
**Endpoint**: `https://huxley2.azurewebsites.net/departures/{crs}/10`  
**Authentication**: National Rail API token required (free registration)  
**Data Displayed**:
- Station name
- Scheduled departure time
- Destination
- Platform number
- Status (On time / delayed time)

**Stations**: King's Cross, Paddington, Euston, Victoria, Waterloo, London Bridge, Liverpool Street, St Pancras

## Requirements

- iOS 17.0+
- Xcode 15.0+
- macOS for development
- National Rail API token (for National Rail widget only)

## How to Build

⚠️ **Important**: These are iOS applications that require Xcode on macOS.

### TfL Widget
1. Open Xcode, create new iOS App with Widget Extension
2. Copy files from `TfL-Widget/` to your Xcode project
3. Ensure shared files are added to both app and widget targets
4. Build and run

### National Rail Widget
1. Register for API token at https://realtime.nationalrail.co.uk/OpenLDBWSRegistration
2. Open Xcode, create new iOS App with Widget Extension
3. Copy files from `NationalRail-Widget/` to your Xcode project
4. Add API token to environment variables in Xcode scheme
5. Build and run

See individual README files for detailed instructions.

## Web Previews

Both widgets have web-based previews that fetch real live data:
- `preview/index.html` - TfL widget preview
- `preview/nationalrail.html` - National Rail widget preview

These demonstrate the exact appearance and functionality of the iOS widgets.

## Recent Changes

- 2025-10-25: Created separate projects for TfL and National Rail widgets
- Both apps use identical station board UI design
- TfL widget uses random Underground stations
- National Rail widget uses random major UK train stations
- Added web previews for both widgets
- Configured 15-minute refresh intervals for both

## User Preferences

- Keep projects completely separate (not combined)
- Use simple station board style without complexity
- Black background with yellow/white text
- Monospaced fonts for authentic look
- Focus on readability

## Technical Notes

- Uses Swift 5.8+ language features
- Async/await for all API calls
- Codable for JSON parsing
- TimelineProvider for automatic widget refresh
- Environment variables for National Rail API token security
- Error handling with try/catch and graceful UI fallbacks

## API Security

- **TfL**: Public API, no authentication needed
- **National Rail**: API token stored in environment variables, never hardcoded in source
