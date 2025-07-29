# GitHub Actions Setup for Unity Builds

This repository uses GitHub Actions to automatically build your Unity project for multiple platforms.

## Prerequisites

Before the workflows can run successfully, you need to set up Unity licensing secrets in your GitHub repository.

### Setting up Unity License

1. **Get your Unity License File**:
   - Install Unity locally and activate it
   - Run this command in your terminal:
     ```bash
     # On macOS/Linux:
     /Applications/Unity/Hub/Editor/6000.0.32f1/Unity.app/Contents/MacOS/Unity -batchmode -createManualActivationFile -quit
     
     # On Windows:
     "C:\Program Files\Unity\Hub\Editor\6000.0.32f1\Editor\Unity.exe" -batchmode -createManualActivationFile -quit
     ```
   - This creates a `Unity_v6000.x.ulf` file

2. **Activate the License**:
   - Go to https://license.unity3d.com/manual
   - Upload the `.alf` file
   - Download the resulting `.ulf` license file

3. **Add Secrets to GitHub**:
   - Go to your repository on GitHub
   - Navigate to Settings > Secrets and variables > Actions
   - Add these secrets:
     - `UNITY_LICENSE`: Contents of your `.ulf` file (open in text editor and copy all)
     - `UNITY_EMAIL`: Your Unity account email
     - `UNITY_PASSWORD`: Your Unity account password

### Alternative: Using Unity Personal License

If you're using Unity Personal (free), you can use a simplified approach:

1. Go to https://github.com/marketplace/actions/unity-request-activation-file
2. Follow the instructions to generate a license for GitHub Actions

## Available Workflows

### 1. Unity Build (Comprehensive)
- **File**: `unity-build.yml`
- **Builds for**: Windows, macOS, Linux, iOS, Android, WebGL
- **Includes**: Automated testing (Play mode and Edit mode)
- **When it runs**: On push to main, pull requests, or manual trigger

### 2. Unity Build (Simple)
- **File**: `unity-build-simple.yml`
- **Builds for**: Windows and WebGL
- **Includes**: Automatic deployment to GitHub Pages (WebGL)
- **When it runs**: On push to main, pull requests, or manual trigger

## Triggering Builds

### Automatic Triggers
- Push to `main` branch
- Create/update a pull request

### Manual Trigger
1. Go to Actions tab in your repository
2. Select the workflow you want to run
3. Click "Run workflow"
4. Select the branch and click "Run workflow"

## Build Artifacts

After a successful build:
- Artifacts are available in the Actions tab
- Click on the workflow run
- Download artifacts from the bottom of the page
- Artifacts are kept for 30-90 days (configurable)

## WebGL Deployment

The simple workflow automatically deploys WebGL builds to GitHub Pages:
1. Enable GitHub Pages in repository settings
2. Set source to "GitHub Actions"
3. Your game will be available at: `https://[username].github.io/LazyPortfolio/`

## Customization

### Adding/Removing Platforms
Edit the `matrix.targetPlatform` section in the workflow files.

### Changing Unity Version
Update `unityVersion: 6000.0.32f1` to your desired version.

### Build Settings
Modify build settings in the `with:` section of the unity-builder action.

## Troubleshooting

### Build Fails with License Error
- Ensure all three secrets are set correctly
- Check if your Unity license is valid
- Try regenerating the license file

### Out of Minutes
- GitHub Actions free tier includes 2000 minutes/month
- Unity builds can be lengthy (~20-30 min per platform)
- Consider building only essential platforms

### Cache Issues
- If builds fail unexpectedly, try clearing the cache
- Go to Actions > Caches and delete old caches

## Resources

- [GameCI Documentation](https://game.ci/docs)
- [Unity Builder Action](https://github.com/game-ci/unity-builder)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
