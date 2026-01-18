# Space Engineers In-game Script Template

## Preparations

1. Use this template on GitHub to create your own script repository.
2. Clone your repository.
3. Open the solution in your C# IDE (Rider or VS should work)
4. Build the `Merge` project

## Usage

### Write your code

- Add your script's code to the `Script` project. 
- Use only C# 6 syntax in your scripts.
- You can use multiple source code files or project as needed.
- From newly added script projects reference the `SpaceEngineers.ScriptingReferences` NuGet package.
- Make sure to have all code which needs to go into the final program in the `Script` namespace.
- Add any unit tests into a separate namespace or even project, for example `Tests`.
- Wrap all debug code into `#if DEBUG` directives.
- For debugging 3D math use the [(DevTool) Programmable Block DebugAPI](https://steamcommunity.com/sharedfiles/filedetails/?id=2654858862) mod and its PB API.

### Merge and deploy your script

- Test merging of your script by running `print_*_script.bat` or your IDE's run configuration (Rider: `Print * script`)
- Customize the output path in `deploy_*_script.bat` and in your IDE's run configurations (Rider: `Deploy * script`)
- Run a deploy script command. It should create or overwrite the output `Script.cs` file you specified.

### Automatically updating code in PBs

It will work only for offline and locally hosted multiplayer games.

- Enable the [ScriptDev](https://github.com/viktor-ferenczi/se-script-dev) plugin in Pulsar.
- Apply the change and restart the game.
- Load your world.
- Append the script's name in square brackets to your PB's name: `Programmable Block [Name Of My Script]`
- The plugin will update the code in your PB whenever the `Script.cs` file changes (it checks the last modification time of the file every second)

If the script is in a subdirectory, then the PB's name must include the directories `/` separated. 

For example: `Programmable Block [My Subdir/Name Of My Script]`

### Shared code, multiple scripts

You can develop multiple scripts in the same solution. You can also split your code into any number of projects.
All what matters while merging the script is the namespaces the tool takes the code from. 

Put your shared code into a separate namespace, then use the `--namespaces` (`-n`) option to select the namespaces
to build your script from. 

For example to develop two scripts in the same solution you could use these namespaces:
- SharedCode
- FirstScript
- SecondScript

Then invoke the merge tool with these parameters to deploy them separately:
- `-n SharedCode,FirstScript -o "%AppData%\SpaceEngineers\IngameScripts\local\FirstScript\Script.cs"`
- `-n SharedCode,SecondScript -o "%AppData%\SpaceEngineers\IngameScripts\local\SecondScript\Script.cs"`

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