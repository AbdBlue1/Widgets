#!/bin/bash

echo "============================================"
echo "UK Transport Widgets - Project Validation"
echo "============================================"
echo ""

# Check if Swift is installed
if command -v swift &> /dev/null; then
    echo "✓ Swift toolchain: $(swift --version | head -n 1)"
else
    echo "✗ Swift toolchain not found"
    exit 1
fi

echo ""
echo "============================================"
echo "TfL Station Widget"
echo "============================================"

tfl_files=(
    "TfL-Widget/Shared/Models.swift"
    "TfL-Widget/Shared/TfLService.swift"
    "TfL-Widget/TfLStationApp/TfLStationApp.swift"
    "TfL-Widget/TfLStationApp/ContentView.swift"
    "TfL-Widget/TfLStationWidget/TfLStationWidget.swift"
    "TfL-Widget/TfLStationWidget/Info.plist"
    "TfL-Widget/Package.swift"
)

all_exist=true
for file in "${tfl_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file"
    else
        echo "✗ $file (missing)"
        all_exist=false
    fi
done

echo ""
echo "============================================"
echo "National Rail Widget"
echo "============================================"

nr_files=(
    "NationalRail-Widget/Shared/Models.swift"
    "NationalRail-Widget/Shared/NationalRailService.swift"
    "NationalRail-Widget/NationalRailApp/NationalRailApp.swift"
    "NationalRail-Widget/NationalRailApp/ContentView.swift"
    "NationalRail-Widget/NationalRailWidget/NationalRailWidget.swift"
    "NationalRail-Widget/NationalRailWidget/Info.plist"
    "NationalRail-Widget/Package.swift"
)

for file in "${nr_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file"
    else
        echo "✗ $file (missing)"
        all_exist=false
    fi
done

echo ""
if $all_exist; then
    echo "✓ All required files present"
else
    echo "✗ Some files are missing"
    exit 1
fi

echo ""
echo "============================================"
echo "Web Previews"
echo "============================================"

if [ -f "preview/index.html" ]; then
    echo "✓ preview/index.html (TfL preview)"
else
    echo "✗ preview/index.html (missing)"
fi

if [ -f "preview/nationalrail.html" ]; then
    echo "✓ preview/nationalrail.html (National Rail preview)"
else
    echo "✗ preview/nationalrail.html (missing)"
fi

echo ""
echo "============================================"
echo "Summary"
echo "============================================"
echo "✓ TfL Station Widget - Complete"
echo "✓ National Rail Widget - Complete"
echo ""
echo "Both apps are iOS applications that require:"
echo "  • macOS with Xcode 15.0+"
echo "  • iOS 17.0+ device or simulator"
echo ""
echo "See README.md for setup instructions."
echo "============================================"
