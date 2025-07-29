# Unity Build Setup Guide

This guide will help you set up automated Unity builds using GitHub Actions with Unity Personal License.

## 🚀 Quick Start

### Step 1: Get Unity License File

1. Go to the **Actions** tab in your GitHub repository
2. Find and click on **"Acquire Unity License Activation File"**
3. Click **"Run workflow"** > Select branch > Click green **"Run workflow"** button
4. Wait for it to complete (usually under a minute)
5. Download the artifact (Unity_v6000.x.alf file) from the workflow run

### Step 2: Activate Unity License

1. Visit https://license.unity3d.com/manual
2. Upload the `.alf` file you downloaded
3. Sign in with your Unity account
4. Select **Unity Personal** license type
5. Download the resulting `.ulf` license file

### Step 3: Add Secrets to GitHub

1. Open the downloaded `.ulf` file in a text editor
2. Copy ALL contents (including the XML tags)
3. Go to your repository's **Settings** > **Secrets and variables** > **Actions**
4. Add these repository secrets:

| Secret Name | Value |
|------------|-------|
| `UNITY_LICENSE` | Entire contents of the .ulf file |
| `UNITY_EMAIL` | Your Unity account email |
| `UNITY_PASSWORD` | Your Unity account password |

### Step 4: Run Your First Build

1. Go to the **Actions** tab
2. Click on **"Unity Build (GameCI)"**
3. Click **"Run workflow"** > Select branch > Run
4. Wait for builds to complete (15-30 minutes)
5. Download build artifacts or visit your GitHub Pages site for WebGL

## 📦 Available Workflows

### Unity Build (GameCI)
- **Purpose**: Main build workflow using official Game CI actions
- **Platforms**: Windows, WebGL (configurable)
- **Features**: 
  - Automatic version detection
  - Semantic versioning
  - GitHub Pages deployment for WebGL
  - Build caching for faster subsequent builds

### Acquire Unity License Activation File
- **Purpose**: One-time setup to get Unity license
- **When to use**: First time setup or when license expires

## 🌐 WebGL on GitHub Pages

Your WebGL build will automatically deploy to:
```
https://[your-username].github.io/[repository-name]/
```

Make sure GitHub Pages is enabled:
1. Go to **Settings** > **Pages**
2. Set **Source** to **GitHub Actions**

## 🔧 Customization

### Add More Platforms

Edit `.github/workflows/unity-build-gameci.yml` and add to the matrix:

```yaml
matrix:
  targetPlatform:
    - StandaloneWindows64
    - WebGL
    - StandaloneOSX  # Add macOS
    - Android        # Add Android
    - iOS           # Add iOS
```

### Change Unity Version

The workflow auto-detects Unity version from `ProjectSettings/ProjectVersion.txt`.
To use a specific version, change:

```yaml
unityVersion: auto
```

to:

```yaml
unityVersion: 6000.1.5f1
```

## ❓ Troubleshooting

### "Invalid version" error
- Make sure you're using the GameCI workflow, not the old Personal License one
- The workflow auto-detects Unity 6 versions correctly

### License activation failed
- Ensure you copied the ENTIRE .ulf file contents
- Check that your Unity email/password are correct
- Try regenerating the license if it's been a while

### Build takes too long
- First builds take longer due to Library generation
- Subsequent builds use cache and are faster
- Consider building only essential platforms

## 📚 Resources

- [Game CI Documentation](https://game.ci/docs)
- [Unity Cloud Build Alternative](https://unity.com/products/cloud-build)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
