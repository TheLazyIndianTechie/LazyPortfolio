using UnityEditor;
using UnityEngine;

public class DisableWebGLCompression
{
    [InitializeOnLoadMethod]
    static void ConfigureWebGLCompression()
    {
        // Disable compression for WebGL builds
        PlayerSettings.WebGL.compressionFormat = WebGLCompressionFormat.Disabled;
        PlayerSettings.WebGL.decompressionFallback = true;
        
        Debug.Log("WebGL compression has been disabled for GitHub Pages compatibility");
    }
}
