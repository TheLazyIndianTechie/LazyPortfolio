# LazyPortfolio

A Unity-based portfolio gallery project showcasing creative works in an interactive 3D environment.

## Project Overview

LazyPortfolio is a Unity project designed to create an immersive gallery experience where users can navigate through a virtual museum space to view and interact with portfolio pieces.

## Features

- 3D gallery/museum environment
- First-person navigation controls
- Multiple exhibition rooms with different architectural styles
- Interactive display areas for portfolio pieces
- Optimized for both PC and mobile platforms

## Technical Details

- **Unity Version**: 6000.0.32f1
- **Render Pipeline**: Universal Render Pipeline (URP)
- **Platform Support**: PC, Mac, Linux, Mobile
- **Input System**: Unity's new Input System

## Project Structure

```
LazyPortfolio/
├── Assets/
│   ├── _Gallery/          # Main gallery assets
│   │   ├── Prefabs/       # Reusable gallery objects
│   │   ├── Scripts/       # Custom scripts
│   │   └── SourceFiles/   # Models, materials, and textures
│   ├── Scenes/            # Unity scenes
│   ├── Settings/          # Render pipeline and project settings
│   └── TutorialInfo/      # Tutorial and documentation
├── Packages/              # Unity package dependencies
└── ProjectSettings/       # Unity project configuration
```

## Getting Started

### Prerequisites

- Unity 6000.0.32f1 or later
- Git for version control

### Installation

1. Clone the repository:
```bash
git clone [repository-url]
```

2. Open the project in Unity Hub:
   - Click "Add" in Unity Hub
   - Navigate to the cloned project folder
   - Select the folder and open with Unity 6000.0.32f1

3. Let Unity import all assets and compile scripts

### Running the Project

1. Open the main scene: `Assets/Scenes/Gallery_Scene.unity`
2. Press Play in the Unity Editor
3. Use WASD keys to move and mouse to look around

## Development

### Adding New Portfolio Items

1. Create or import your 3D models/artwork
2. Place them in appropriate folders under `Assets/_Gallery/`
3. Create prefabs for reusable items
4. Position them in the gallery scene

### Building

The project includes settings for both PC and Mobile platforms:
- PC uses `PC_RPAsset` render pipeline settings
- Mobile uses `Mobile_RPAsset` for optimized performance

## Contributing

Feel free to contribute to this project by:
- Adding new features
- Improving performance
- Fixing bugs
- Enhancing the gallery experience

## License

[Add your license information here]

## Contact

[Add your contact information here]

---

Created as part of LazyGameDevs teaching materials.
