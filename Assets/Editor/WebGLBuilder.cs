using UnityEditor;
using UnityEditor.Build.Reporting;
using UnityEngine;
using System.IO;
using System.Linq;

public class WebGLBuilder
{
    [MenuItem("Build/Build WebGL")]
    public static void BuildWebGL()
    {
        BuildWebGLCommandLine();
    }

    public static void BuildWebGLCommandLine()
    {
        // Ensure compression is disabled
        PlayerSettings.WebGL.compressionFormat = WebGLCompressionFormat.Disabled;
        PlayerSettings.WebGL.decompressionFallback = true;
        
        Debug.Log("Building WebGL with compression disabled...");
        
        string buildPath = Path.Combine(Directory.GetCurrentDirectory(), "build/WebGL/WebGL");
        
        // Ensure the directory exists
        string buildDir = Path.GetDirectoryName(buildPath);
        if (!Directory.Exists(buildDir))
        {
            Directory.CreateDirectory(buildDir);
        }
        
        BuildPlayerOptions buildPlayerOptions = new BuildPlayerOptions();
        buildPlayerOptions.scenes = EditorBuildSettings.scenes
            .Where(scene => scene.enabled)
            .Select(scene => scene.path)
            .ToArray();
        buildPlayerOptions.locationPathName = buildPath;
        buildPlayerOptions.target = BuildTarget.WebGL;
        buildPlayerOptions.options = BuildOptions.None;

        BuildReport report = BuildPipeline.BuildPlayer(buildPlayerOptions);
        
        if (report.summary.result == UnityEditor.Build.Reporting.BuildResult.Succeeded)
        {
            Debug.Log("Build succeeded: " + report.summary.totalSize + " bytes");
        }
        else
        {
            Debug.LogError("Build failed");
            EditorApplication.Exit(1);
        }
    }
}
