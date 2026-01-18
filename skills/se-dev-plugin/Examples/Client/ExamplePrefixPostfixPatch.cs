using System.Diagnostics.CodeAnalysis;
using HarmonyLib;
using Sandbox.Game.Multiplayer;

namespace ClientPlugin.Patches;

// ReSharper disable once UnusedType.Global
[HarmonyPatch(typeof(MyPlayerCollection))]
[SuppressMessage("ReSharper", "UnusedType.Global")]
[SuppressMessage("ReSharper", "UnusedMember.Global")]
public static class MyPlayerCollectionPatch
{
    private static Config Config => Config.Current;

    [HarmonyPrefix]
    [HarmonyPatch(nameof(MyPlayerCollection.SendDirtyBlockLimits))]
    public static bool SendDirtyBlockLimitsPrefix()
    {
        // Use the config to enable patches corresponding to your plugin's features
        if (!Config.Toggle)
            return true;
        
        // Your logic to run before or instead the original method implementation.
        // You cannot and should not attempt to call the original method here.
            
        // Return false to replace the original method, make sure any return value and out arguments are handled.
        // Return true to call the original method.
        return true;
    }
    
    [HarmonyPostfix]
    [HarmonyPatch(nameof(MyPlayerCollection.SendDirtyBlockLimits))]
    public static void SendDirtyBlockLimitsPostfix()
    {
        // Use the config to enable patches corresponding to your plugin's features
        if (!Config.Toggle)
            return;
        
        // Your logic to run after the original method implementation.
    }
}
