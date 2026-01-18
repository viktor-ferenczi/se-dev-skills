# In-game Script Merge Tool for Space Engineers

`ScriptMerge` is a command line tool for merging in-game scripts from multiple source code files. 

It can also minify the script for release, so it can fit under the 100k characters limit. 

Please consider supporting my work on [Patreon](https://www.patreon.com/semods) or one time via [PayPal](https://www.paypal.com/paypalme/vferenczi/).

## Create a script project

- Install .NET Framework 4.8.1 (if you don't have it)
- Create .Net Framework 4.8.1 Class Library project
- Configure the project for C# 6.0 syntax
- Reference these NuGet packages from the project:
  - `SpaceEngineers.ScriptingReferences`
  - `System.Collections.Immutable` 
- Use the `Script/Skeleton.cs` file from this repository as a starting point for your script code
- See the `TODO` comments in the skeleton for more
- See the **Hints** below

## Merge your script

Build and use `IngameScriptMergeTool` to merge your script source into a single file:

### Help 

`IngameScriptMergeTool --help`

```
Description:
  Command line tool to merge a Space Engineers script from multiple source code files.

Usage:
  IngameScriptMergeTool [options]

Options:
  -s, --solution <solution>    Path to the solution file, it must include all projects your script depends on [default: *.sln]
  -n, --namespace <namespace>  Comma separated list of namespaces containing the code to be merged into the script [default: Script]
  -d, --deploy <deploy>        Deploy the script into SE's IngameScripts folder with this name (prints to stdout if not given)
  -m, --minify                 Minify the source code by removing all comments and most unnecessary whitespace [default: False]
  -u, --unicode                Shorten all names to single Unicode letters, exclusion: //! KeepThisName [default: False]
  -a, --aggressive             Aggressively compress code (reduces repeated string literals) (requires --unicode) [default: False]
  -r, --release                Enables release mode, it removes #ifdef DEBUG ... #endif blocks [default: False]
  --version                    Show version information
  -?, -h, --help               Show help and usage information
```

### Examples

- Print debug merge: `IngameScriptMergeTool`
- Print release merge: `IngameScriptMergeTool -maur` 
- Deploy debug merge: `IngameScriptMergeTool -d "Name Of My Script"`
- Deploy release merge: `IngameScriptMergeTool -maur -d "Name Of My Script"` 

The deployment target is SE's script folder: `%AppData%\SpaceEngineers\IngameScript\local\Name Of My Script`

## Hints

- For debugging 3D math use the [(DevTool) Programmable Block DebugAPI](https://steamcommunity.com/sharedfiles/filedetails/?id=2654858862) mod and its PB API
- Add your unit tests (if any) into a separate namespace (for example `Tests`)
- Make sure to wrap all debug code into `#if DEBUG` directives
- Subdirectories are allowed, use `/` as a delimiter, or example: `My Subdir/Name Of My Script`

### Excluding names from shortening

- Specific names (everywhere): `//! KeepThisName, KeepThatName`
- On the line of declaration: `const string DontRenameThis = "x"; //!`
- Enum values, sometimes they are shown to the player: `KeepThisEnumValue, //!`

### Header

Adding `//!!` anywhere in a namespace declaration will move that namespace block to the
top of the merged script and exludes it from variable renaming and minification.
This is useful to add documentation and configuration supposed to be editable by the player. 

```cs
namespace Script {
    //!!
    /* Example script */
    static class Config {
        // This is a configuration variable
        public static ConfigVar = 1; 
    }
}
```

### Automatically updating code in PBs

- Enable the [ScriptDev](https://github.com/viktor-ferenczi/se-script-dev) plugin in Pulsar, Apply, restart SE.
- Append the script's name in square brackets to your PB's name: `Programmable Block [Name Of My Script]`
- The plugin will update the code in your PB whenever the `Script.cs` file changes.

### Debug and release only code

You can wrap debug and release code into directives as you would in regular C# code:

```cs
#if DEBUG
    Echo("DEBUG");
#endif

#if !DEBUG
    Echo("RELEASE");
#endif
```

The directives themselves are removed, only their body are preserved during merging.

### Multiple scripts with code sharing

You can develop multiple scripts in the same solution. You can also split your code into any number of projects.
All what matters while merging the script is the namespaces the tool takes the code from. 

Put your shared code into a separate namespace, then use the `--namespaces` (`-n`) option to select the namespaces
to build your script from. 

For example to develop two scripts in the same solution you could use these namespaces:
- SharedCode
- FirstScript
- SecondScript

Then invoke the merge tool with these parameters to deploy them separately:
- `-n SharedCode,FirstScript -d "First Script"`
- `-n SharedCode,SecondScript -d "Second Script"`

### PB API whitelist checking

This is a simpler tool than MDK and does not depend on Visual Studio. However, it does not verify
the script against the PB API whitelist, currently. It could be implemented based on the same whitelist
file of MDK, should enough script developers request it. The type information is already available,
since it is required for proper minification.
