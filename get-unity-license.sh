#!/bin/bash

# Unity License Activation Helper Script
# This script helps you generate a Unity license file for GitHub Actions

echo "Unity License Generation Helper"
echo "=============================="
echo ""

# Detect Unity installation
UNITY_PATH=""

if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS - Check custom path first
    if [ -d "/Volumes/LazyGameDevs/Applications/Unreal/UE_5.6/Engine/Binaries/ThirdParty/Unity" ]; then
        UNITY_PATH="/Volumes/LazyGameDevs/Applications/Unreal/UE_5.6/Engine/Binaries/ThirdParty/Unity/Unity.app/Contents/MacOS/Unity"
    elif [ -d "/Applications/Unity/Hub/Editor/6000.0.32f1" ]; then
        UNITY_PATH="/Applications/Unity/Hub/Editor/6000.0.32f1/Unity.app/Contents/MacOS/Unity"
    fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    # Windows
    UNITY_PATH="C:/Program Files/Unity/Hub/Editor/6000.0.32f1/Editor/Unity.exe"
else
    # Linux
    UNITY_PATH="$HOME/Unity/Hub/Editor/6000.0.32f1/Editor/Unity"
fi

if [ ! -f "$UNITY_PATH" ]; then
    echo "Unity installation not found at expected location."
    echo "Please enter the full path to your Unity executable:"
    read -r UNITY_PATH
fi

echo "Using Unity at: $UNITY_PATH"
echo ""

# Generate activation file
echo "Generating Unity license activation file..."
"$UNITY_PATH" -batchmode -createManualActivationFile -quit

if [ -f "Unity_v6000.x.alf" ]; then
    echo ""
    echo "SUCCESS! Activation file created: Unity_v6000.x.alf"
    echo ""
    echo "Next steps:"
    echo "1. Go to: https://license.unity3d.com/manual"
    echo "2. Upload the Unity_v6000.x.alf file"
    echo "3. Download the resulting .ulf license file"
    echo "4. Add the contents of the .ulf file as a GitHub secret named UNITY_LICENSE"
    echo ""
    echo "See .github/workflows/README.md for detailed instructions."
else
    echo "ERROR: Failed to create activation file."
    echo "Please check your Unity installation and try again."
fi
