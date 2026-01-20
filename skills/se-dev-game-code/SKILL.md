---
name: se-dev-game-code
description: Allows reading the decompiled C# code of Space Engineers version 1.  
license: MIT
---
If the `Prepare.DONE` file is missing, then start by following the steps in `Prepare.md` first.

A Python virtual environment in this folder was made available by the preparation, you can use that.
Use `uv run script_name.py` in this folder (as CWD) to run your scripts.
Python packages available (see `pyproject.toml` for the details if needed):
- `lxml` for XML parsing and processing
- `tree-sitter` for C#, HLSL, JSON, Markdown, Python, XML

Use the code indexes generated during preparation to efficiently search the decompiled game code.
Read the docstring at `search_code.py` for usage, that's in the first 35 lines of that file.

The textual part of the game's `Content` is copied into the `Content` folder, so you can use free text search in it:
- Language translations, including the string IDs
- Block and other entity definitions
- Default blueprints and scenarios

General rules:
- Do not use bash on Windows, always write cmd or PowerShell commands.
- The `&&` delimiter does not work between `cmd` commands on Windows, use single `&` instead!
- In the `Decompiled` folder search only inside the C# source files (*.cs) in general. If you work on transpiler or preloader patches, then also search in the IL code (*.il) files.
- In the `Content` folder search the files appropriate for the task. See `ContentTypes.md` for the list of types.
- Do not search for decompiled game code outside the `Decompiled` folder which is at the same level as this skill file. The decompiled game source tree must be there is the preparation succeeded.
- Do not search for game content data outside the `Content` folder which is at the same level as this skill file. The copied game content must be there is the preparation succeeded.
