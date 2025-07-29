#!/bin/bash

# Unity License Activation Helper Script
# This script helps you generate a Unity license file for GitHub Actions

echo "Unity License Generation Helper"
echo "=============================="
echo ""

# Function to find Unity installations
find_unity_installations() {
    local installations=()
    
    # Check custom LazyGameDevs path
    if [ -d "/Volumes/LazyGameDevs/Applications/Unity" ]; then
        for unity_dir in /Volumes/LazyGameDevs/Applications/Unity/*/Unity.app/Contents/MacOS/Unity; do
            if [ -f "$unity_dir" ]; then
                installations+=("$unity_dir")
            fi
        done
    fi
    
    # Check standard Unity Hub locations
    if [ -d "/Applications/Unity/Hub/Editor" ]; then
        for unity_dir in /Applications/Unity/Hub/Editor/*/Unity.app/Contents/MacOS/Unity; do
            if [ -f "$unity_dir" ]; then
                installations+=("$unity_dir")
            fi
        done
    fi
    
    # Check user's Unity Hub locations
    if [ -d "$HOME/Applications/Unity/Hub/Editor" ]; then
        for unity_dir in "$HOME/Applications/Unity/Hub/Editor"/*/Unity.app/Contents/MacOS/Unity; do
            if [ -f "$unity_dir" ]; then
                installations+=("$unity_dir")
            fi
        done
    fi
    
    echo "${installations[@]}"
}

# Detect Unity installations
echo "Searching for Unity installations..."
IFS=' ' read -ra UNITY_INSTALLATIONS <<< "$(find_unity_installations)"

if [ ${#UNITY_INSTALLATIONS[@]} -eq 0 ]; then
    echo "No Unity installations found automatically."
    echo ""
    echo "For macOS, the Unity executable path should look like:"
    echo "  /path/to/Unity.app/Contents/MacOS/Unity"
    echo ""
    echo "Please enter the full path to your Unity executable:"
    read -r UNITY_PATH
else
    echo ""
    echo "Found Unity installations:"
    echo ""
    
    # Display found installations
    for i in "${!UNITY_INSTALLATIONS[@]}"; do
        version=$(echo "${UNITY_INSTALLATIONS[$i]}" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+[a-z][0-9]+' || echo "Unknown")
        echo "  $((i+1)). Unity $version"
        echo "      ${UNITY_INSTALLATIONS[$i]}"
        echo ""
    done
    
    # If only one installation, use it automatically
    if [ ${#UNITY_INSTALLATIONS[@]} -eq 1 ]; then
        UNITY_PATH="${UNITY_INSTALLATIONS[0]}"
        echo "Using the only Unity installation found."
    else
        # Ask user to select
        echo "Please select a Unity installation (enter number):"
        read -r selection
        
        # Validate selection
        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#UNITY_INSTALLATIONS[@]} ]; then
            UNITY_PATH="${UNITY_INSTALLATIONS[$((selection-1))]}"
        else
            echo "Invalid selection. Please enter the full path to your Unity executable:"
            read -r UNITY_PATH
        fi
    fi
fi

# Verify the Unity path exists and is executable
if [ ! -f "$UNITY_PATH" ]; then
    echo ""
    echo "ERROR: Unity executable not found at: $UNITY_PATH"
    echo "Please check the path and try again."
    exit 1
fi

if [ ! -x "$UNITY_PATH" ]; then
    echo ""
    echo "ERROR: Unity file is not executable: $UNITY_PATH"
    echo "Making it executable..."
    chmod +x "$UNITY_PATH"
fi

echo ""
echo "Using Unity at: $UNITY_PATH"
echo ""

# Clean up any existing activation files
if [ -f "Unity_v*.alf" ]; then
    echo "Removing existing activation files..."
    rm Unity_v*.alf
fi

# Generate activation file
echo "Generating Unity license activation file..."
echo "This may take a moment..."
echo ""

# Run Unity with proper parameters
"$UNITY_PATH" -batchmode -quit -createManualActivationFile -logFile unity_activation.log 2>&1

# Wait a moment for file creation
sleep 2

# Check if activation file was created
ALF_FILE=$(ls Unity_v*.alf 2>/dev/null | head -n 1)

if [ -f "$ALF_FILE" ]; then
    echo "SUCCESS! Activation file created: $ALF_FILE"
    echo ""
    echo "Next steps:"
    echo "1. Go to: https://license.unity3d.com/manual"
    echo "2. Upload the $ALF_FILE file"
    echo "3. Download the resulting .ulf license file"
    echo "4. Add the contents of the .ulf file as a GitHub secret:"
    echo "   - Go to: https://github.com/TheLazyIndianTechie/LazyPortfolio/settings/secrets/actions"
    echo "   - Click 'New repository secret'"
    echo "   - Name: UNITY_LICENSE"
    echo "   - Value: Contents of the .ulf file"
    echo ""
    echo "Also add these secrets:"
    echo "   - UNITY_EMAIL: Your Unity account email"
    echo "   - UNITY_PASSWORD: Your Unity account password"
    echo ""
    echo "See .github/workflows/README.md for detailed instructions."
else
    echo "ERROR: Failed to create activation file."
    echo ""
    echo "Checking Unity log for errors..."
    if [ -f "unity_activation.log" ]; then
        echo "--- Unity Log ---"
        tail -20 unity_activation.log
        echo "--- End of Log ---"
        echo ""
        echo "Full log saved to: unity_activation.log"
    fi
    echo ""
    echo "Common issues:"
    echo "- Make sure Unity is not already running"
    echo "- Try closing Unity Hub if it's open"
    echo "- Ensure you have write permissions in this directory"
fi

# Cleanup log file if successful
if [ -f "$ALF_FILE" ] && [ -f "unity_activation.log" ]; then
    rm unity_activation.log
fi
