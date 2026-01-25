General instructions:
- Write the logic and patches into the Shared project. Add code in the target-specific projects (Client, Dedicated, Torch) only if it belongs only to that target necessary.
- Write all new patches using the Harmony patching library. Never use the Torch patcher for any new patches.

Building the project:
- In development the plugin is built by the `dotnet` command line tool or by an IDE like VSCode, JetBrains Rider or Visual Studio. 
- In development the DLLs built are deployed to their respective "plugins" folders by the `Deploy.bat` script each project:
  - Client: Into Pulsar's `Local` plugin folder
  - Dedicated: Into the Dedicated Server's `Plugins` folder
  - Torch: Into Torch's `Plugins` folder
- In production both the DS and Torch are using pre-build `Release` DLLs. On DS the server admin must copy it into the `Plugins` folder. On Torch either copy the DLL or upload the plugin to torchapi.net (must be done manually with Discord authentication).  

Runtime patching:
- Torch has an obsolete custom patcher. Do not use that for any patches, just use Harmony as usual. The client and server code can be patched the same way, most classes and methods are available on both. Some methods are running (used) only on the client, some only on the server, but most are used both on the server and the client.
- Each target (Client, Dedicated, Torch) has a separate main `Plugin.cs` file with a `Plugin` class specific to that target. Start from there to understand the target.

Example patches: 
- `Examples/Server/ExamplePatch.cs` Prefix and Postfix patches 
- `Examples/Server/ExampleServerPatch.cs` Patch to run only on servers (DS, Torch), but not on client (game) 
- `Examples/Server/ExampleTranspilerPatch.cs` Transpiler patch (see the IL files for its effect on the modified method's body)

Folder structure of a client-server (multi-targeted) plugin:
- `.run`: JetBrains Rider run configurations (for convenience)
- `Doc`: Images linked from the README file or any further documentation should go here.
- `Shared`: Shared project with all the code which is used on at least two out of the three targets, usually on all three.
- `Shared/Config`: Shared configuration interface and persistence code.
- `Shared/Logging`: Shared logging interface and log formatting code.
- `Shared/Patches`: Use this folder and namespace to host the Harmony patches. 
- `Shared/Plugin`: Shared plugin initialization and update handler code.
- `Shared/Tools`: Shared utility code for transpiler patches, detecting game code changes by IL code hash and checking if the game runs on Linux (Wine/Proton).
- `ClientPlugin`: Pulsar builds only the source code under this folder or its subdirectories. You can find plugin initialization, configuration and logging directly in this folder.
- `ClientPlugin/Settings`: Reusable configuration dialog components. See `Config.cs` in the project directory on usage examples.
- `DedicatedPlugin`: Code specific to the Dedicated Server.
- `TorchPlugin`: Code specific to the Torch Server.
- `TorchPlugin\ConfigView.xaml`: Description of the plugin configuration form loaded by the Torch Server.

References:
- [Client and server (both DS and Torch) plugin template](https://github.com/viktor-ferenczi/se-server-plugin-template) Template repository to start a new project.
