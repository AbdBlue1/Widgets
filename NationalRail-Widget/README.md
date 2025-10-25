# National Rail Departures Widget for iOS

A minimal iOS widget displaying live UK train departures in a classic station board style.

## Quick Start

This is an iOS app that requires **Xcode on macOS** to build and run.

### Setup Instructions

1. **Register for National Rail API Access**:
   - Visit: https://realtime.nationalrail.co.uk/OpenLDBWSRegistration
   - Get your API token (free for up to 5 million requests per 4 weeks)

2. **Create Xcode Project**:
   - Open Xcode and create a new iOS App project
   - Add a Widget Extension target
   - Copy the Swift files from this repository to your Xcode project:
     - `Shared/Models.swift` → Add to both app and widget targets
     - `Shared/NationalRailService.swift` → Add to both app and widget targets
     - `NationalRailApp/ContentView.swift` → Main app target
     - `NationalRailWidget/NationalRailWidget.swift` → Widget extension target

3. **Configure API Token**:
   - In Xcode, select your widget scheme
   - Edit Scheme → Run → Arguments → Environment Variables
   - Add: `NATIONAL_RAIL_API_TOKEN` = `your-api-token-here`

4. Build and run on your device or simulator (iOS 17+)
5. Add the widget to your home screen

## Features

✅ Simple station board design (black background, yellow/white text)  
✅ Live data from National Rail API via Huxley proxy  
✅ Random station selection from 8 major UK stations  
✅ Auto-refresh every 15 minutes  
✅ Shows scheduled time, destination, platform, and status  
✅ Native implementation, no external dependencies  

## Widget Display

The widget shows:
- Station name at the top
- Up to 4 upcoming departures
- Scheduled departure time (e.g., "14:30")
- Destination (e.g., "BRISTOL TEMPLE MEADS")
- Platform number (e.g., "1")
- Status (e.g., "ON TIME" or "14:35" if delayed)

All in uppercase monospaced font on a black background.

## Stations Included

- King's Cross
- Paddington
- Euston
- Victoria
- Waterloo
- London Bridge
- Liverpool Street
- St Pancras

## Requirements

- iOS 17.0+
- Xcode 15.0+
- SwiftUI & WidgetKit
- National Rail API token (free registration)

## API Information

Uses the Huxley REST proxy for National Rail data:  
`https://huxley2.azurewebsites.net/departures/{crs}/10`

The Huxley API converts the official SOAP-based National Rail API to easy-to-use JSON.

## Security Note

The API token is stored in environment variables and is never hardcoded in the source files. Make sure to add it to your Xcode scheme's environment variables or use iOS Secrets management for production apps.
