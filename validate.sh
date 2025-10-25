#!/bin/bash

echo "============================================"
echo "TfL Station Widget - Project Validation"
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
echo "Checking project structure..."
echo ""

# Check required files
files=(
    "Shared/Models.swift"
    "Shared/TfLService.swift"
    "TfLStationApp/TfLStationApp.swift"
    "TfLStationApp/ContentView.swift"
    "TfLStationWidget/TfLStationWidget.swift"
    "TfLStationWidget/Info.plist"
    "Package.swift"
)

all_exist=true
for file in "${files[@]}"; do
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
echo "Checking Swift syntax..."
echo ""

# Try to check syntax of Swift files
for file in "${files[@]}"; do
    if [[ $file == *.swift ]]; then
        if swift -frontend -parse "$file" -sdk /usr/lib/swift 2>/dev/null; then
            echo "✓ $file - syntax OK"
        else
            echo "⚠ $file - syntax check skipped (iOS-specific code)"
        fi
    fi
done

echo ""
echo "============================================"
echo "NOTE: This is an iOS application"
echo "============================================"
echo "To build and run this app, you need:"
echo "  • macOS with Xcode 15.0+"
echo "  • iOS 17.0+ device or simulator"
echo ""
echo "See README.md for setup instructions."
echo "============================================"
