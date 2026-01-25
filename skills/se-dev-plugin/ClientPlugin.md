Building the project:
- In production the plugin is built by the Pulsar plugin loader directly on the player's machine.
- In development the plugin is built either of these ways:
  - By the `dotnet` command line tool or by an IDE like VSCode, JetBrains Rider or Visual Studio. Then the DLL built is deployed to Pulsar's `Local` plugin folder by the `Deploy.bat` script.
  - By Pulsar using the local development folder feature (needs to be configured in Pulsar).

Example patches: 
- `Examples/Client/ExamplePrefixPostfixPatch.cs` Prefix and Postfix patches 
- `Examples/Client/ExampleTranspilerPatch.cs` Transpiler patch (see the IL files for its effect on the modified method's body)

Folder structure of a client-only plugin:
- `.run`: JetBrains Rider run configurations (for convenience)
- `Docs`: Images linked from the README file or any further documentation should go here.
- `ClientPlugin`: Pulsar builds only the source code under this folder or its subdirectories. You can find plugin initialization, configuration and logging directly in this folder.
- `ClientPlugin/Settings`: Reusable configuration dialog components. See `Config.cs` in the project directory on usage examples.
- `ClientPlugin/Tools`: Utility code for transpiler patches.
- `ClientPlugin/Patches`: Use this folder and namespace to host the Harmony patches.

References:
- [Client plugin template](https://github.com/viktor-ferenczi/se-client-plugin-template) Template repository to start a new project.
