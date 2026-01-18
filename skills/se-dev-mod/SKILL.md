---
name: se-dev-script
description: Mod development for Space Engineers version 1
license: MIT
---
Do the one-time preparation steps described in `Prepare.md`, but only if the `Prepare.DONE` file is missing.

How to search for examples in the code of existing mods:
- A Python virtual environment in this folder was made available by the preparation.
- Write short, reusable Python scripts to conduct custom code search. Strive for speed and minimal output. 
- Use `uv run script_name.py` in this folder (as CWD) to run your scripts.
- Python packages available (see `pyproject.toml` for the details if needed):
  - `lxml`
  - `tree-sitter` for C#, HLSL, JSON, Markdown, Python, XML
- The `SteamMods` folder contains game content (mods, scripts, blueprints) the player downloaded. Filter mods by the existence of a non-empty `Data/Scripts` folder inside the numbered content folder. 
- The `LocalMods` folder contains mods the player is developing. It is a link to `%AppData%/SpaceEngineers/Mods`.

Use only names matching the Mod API whitelist: [ModApiWhitelist.txt](ModApiWhitelist.txt)
The whitelist was exported from game version `1.208.015` using MDK2's `Mdk.Extractor`.

Use the `se-dev-game-code` skill to search the game's decompiled code. You may need this to
understand how the game's internals work and how to interface with it properly. Stick to
game code searches corresponding to names on the Mod API whitelist for efficiency.

References:
- [Mod Template repo](https://github.com/viktor-ferenczi/se-mod-template) mod script template repository to start a new project. See [ModTemplate.md](ModTemplate.md)
- [Mod Development Kit (MDK2)](https://github.com/malforge/mdk2)
- [Mod API for script mods](https://malforge.github.io/spaceengineers/modapi/index.html)
