using System;
using System.Collections.Generic;
using Mono.Cecil;

// DO NOT USE A NAMESPACE!
//namespace ClientPlugin;

public class Preloader
{
    // Full filenames of the game DLLs to patch (not full path)
    public static IEnumerable<string> TargetDLLs { get; } =
    [
        "Sandbox.Game.dll"
    ];

    // Runs before any of the preloader patches of any of the plugins
    public static void Initialize()
    {
        Console.WriteLine("Initialize");
    }

    // Runs for each of the assemblies listed in TargetDLLs
    public static void Patch(AssemblyDefinition assembly)
    {
        Console.WriteLine("Patch");
    }

    // Runs right before Space Engineers starts
    public static void Finish()
    {
        Console.WriteLine("Finish");
    }
}