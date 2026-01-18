---
name: se-dev-script
description: In-game (programmable block, aka PB) script development for Space Engineers version 1
license: MIT
---
Do the one-time preparation steps described in `Prepare.md`, but only if the `Prepare.DONE` file is missing.

How to search for examples in the code of existing PB scripts:
- A Python virtual environment in this folder was made available by the preparation.
- Write short, reusable Python scripts to conduct custom code search. Strive for speed and minimal output. 
- Use `uv run script_name.py` in this folder (as CWD) to run your scripts.
- Python packages available (see `pyproject.toml` for the details if needed):
  - `lxml`
  - `tree-sitter` for C#, Markdown, Python, XML
- The `SteamScripts` folder contains game content (mods, scripts, blueprints) the player downloaded. Filter scripts by the existence of a `Script.cs` file directly in the numbered content folder. 
- The `LocalScripts` folder contains mods the player is developing. It is a link to `%AppData%/SpaceEngineers/IngameScripts`.

Use only names matching the PB API whitelist: [PBApiWhitelist.txt](PBApiWhitelist.txt)
The whitelist was exported from game version `1.208.015` using MDK2's `Mdk.Extractor`.

Use the `se-dev-game-code` skill to search the game's decompiled code. You may need this to
understand how the game's internals work and how to script it properly. Stick to game code
searches corresponding to names on the PB API whitelist for efficiency.

References:
- [Script Template repo](https://github.com/viktor-ferenczi/se-script-template) PB script template repository to start a new project. See [ScriptTemplate.md](ScriptTemplate.md)
- [Script Merge tool](https://github.com/viktor-ferenczi/se-script-merge) Merging PB scripts from C# projects into single file with optional code compression. See [ScriptMerge.md](ScriptMerge.md)
- [Script Dev plugin](https://github.com/viktor-ferenczi/se-script-dev) Automatic script loading into the PB in-game for easier testing. See [ScriptDev.md](ScriptDev.md)
- [Mod Development Kit (MDK2)](https://github.com/malforge/mdk2)
- [Programmable Block API](https://malforge.github.io/spaceengineers/pbapi)
- [Wiki on Scripting](https://spaceengineers.wiki.gg/wiki/Scripting)
